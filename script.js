let currentData = [];
let currentTable = '';
let selectedRow = null;
let currentMode = ''; 
let currentViewMode = 'table';

window.onload = () => {
    const firstBtn = document.querySelector('.nav-btn');
    if(firstBtn) loadTable('SETURI', document.querySelectorAll('.nav-btn')[0]);
};

async function loadTable(tableName, btnElement) {
    const btnAdd = document.querySelector('.btn-add');
    if(btnAdd) btnAdd.disabled = false;
    const viewActions = document.getElementById('viewModeActions');
    currentTable = tableName;

    const btnScryfallCard = document.getElementById('btnScryfall');
    const btnScryfallSet = document.getElementById('btnScryfallSet');
    if(btnScryfallCard) btnScryfallCard.style.display = 'none';
    if(btnScryfallSet) btnScryfallSet.style.display = 'none';

    if (tableName === 'CARTI' && btnScryfallCard) btnScryfallCard.style.display = 'inline-block';
    else if (tableName === 'SETURI' && btnScryfallSet) btnScryfallSet.style.display = 'inline-block';
    if(tableName === 'CARTI_SETURI' || tableName === 'PACHETE_CARTI' || tableName === 'MECIURI_JUCATORI' || tableName === 'PACHETE_MECIURI'){
        viewActions.style.display = 'none';
    }
    else{
        if(viewActions) viewActions.style.display = 'flex';
    }

    selectedRow = null;
    updateButtons();
    
    if (btnElement) {
        document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
        btnElement.classList.add('active');
    }

    const titleEl = document.getElementById('tableTitle');
    if(titleEl) titleEl.innerText = tableName;

    document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px; color:#aaa;">Se caută datele...</div>';

    let apiEndpoint = tableName;

    if (tableName === 'PACHETE' && currentViewMode === 'gallery') {
        apiEndpoint = 'V_PACHETE_GALERIE';
    }

    try {
        const res = await fetch(`http://localhost:3000/api/table/${apiEndpoint}`);
        if (!res.ok) throw new Error(await res.text());
        
        const data = await res.json();
        currentData = data;
        
        renderCurrentView(); 
        
    } catch (e) {
        document.getElementById('tableWrapper').innerHTML = `<div class="error-msg"><strong>EROARE:</strong> ${e.message}</div>`;
    }
}


function switchView(mode) {
    if (currentViewMode === mode) return;

    currentViewMode = mode;
    updateViewButtonsUI();
    
    if (currentTable === 'PACHETE') {
        loadTable('PACHETE', null);
    } else {
        renderCurrentView();
        selectedRow = null;
        updateButtons();
    }
}

function updateViewButtonsUI() {
    document.getElementById('btnViewTable').classList.remove('view-active');
    document.getElementById('btnViewGallery').classList.remove('view-active');

    if (currentViewMode === 'table') {
        document.getElementById('btnViewTable').classList.add('view-active');
    } else {
        document.getElementById('btnViewGallery').classList.add('view-active');
    }
}

function renderCurrentView() {
    if (currentViewMode === 'gallery') {
        renderCardGallery(currentData);
    } else {
        renderTable(currentData);
    }
}

function renderTable(data) {
    if (!data || data.length === 0) {
        document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px; color:#aaa;">Nu există date.</div>';
        return;
    }
    const cols = Object.keys(data[0]);
    let html = '<table><thead><tr>';
    cols.forEach(c => html += `<th onclick="sortTable('${c}')">${c}</th>`);
    html += '</tr></thead><tbody>';
    
    data.forEach((row, index) => {
        html += `<tr onclick="selectRow(this, ${index})">`;
        cols.forEach(c => {
            let val = row[c] !== null ? row[c] : '';
            
            if (typeof val === 'string' && val.includes('T') && /^\d{4}-\d{2}-\d{2}T/.test(val)) {
                val = val.split('T')[0];
            }
            else if (c === 'URL_IMAGINE' && val.startsWith('http')) {
                val = `<img src="${val}" class="card-thumb" alt="Card Art">`;
            }
            else if (c=== 'URL_IMAGINE_SET' && val.startsWith('http')) {
                val = `<img src="${val}" class="table-set-icon" alt="Set Icon">`;
            }
            else if (c === 'DESCRIERE' || val.length > 50) {
                val = `<span class="truncate" title="${val}">${val}</span>`;
            }

            html += `<td>${val}</td>`;
        });
        html += '</tr>';
    });
    html += '</tbody></table>';
    document.getElementById('tableWrapper').innerHTML = html;
}

function renderCardGallery(data) {
    if(currentTable=='CARTI'){
        if (!data || data.length === 0) {
            document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px;">Nu există date pentru galerie.</div>';
            return;
        }
        let html = '<div class="card-grid">';
        data.forEach((row, index) => {
            let imgSrc = 'https://gatherer.wizards.com/Handlers/Image.ashx?type=card&name=Card+Back';
            
            if (row.URL_IMAGINE && (row.URL_IMAGINE.startsWith('http') || row.URL_IMAGINE.startsWith('https'))) {
                imgSrc = row.URL_IMAGINE;
            }

            html += `
                <div class="mtg-card" onclick="selectCardGallery(this, ${index})">
                    <div class="card-img-wrapper">
                        <img src="${imgSrc}" onerror="this.src='https://gatherer.wizards.com/Handlers/Image.ashx?type=card&name=Card+Back'">
                    </div>
                    <div class="card-name">CANTITATE: ${row.NUMAR_DETINUT}</div>
                </div>`;
        });
        html += '</div>';
        document.getElementById('tableWrapper').innerHTML = html;
    }
    if(currentTable=='SETURI'){
        if (!data || data.length === 0) {
            document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px;">Nu există date pentru galerie.</div>';
            return;
        }
        let html = '<div class="card-grid">';
        data.forEach((row, index) => {

            html += `
            <div class="gallery-item-set" onclick="selectCardGallery(this, ${index})">
                <img src="${row.URL_IMAGINE_SET}" class="gallery-set-icon" onerror="this.style.display='none'">
                
                <div>
                    <span class="gallery-set-title">${row.NUME_SET}</span>
                    
                    <div class="gallery-set-meta">
                        Lansare: <span class="gallery-set-val">${row.DATA_LANSARE ? row.DATA_LANSARE.split("T")[0] : 'N/A'}</span>
                        <span style="margin: 0 5px; color: #444;">|</span> 
                        Cărți: <span class="gallery-set-val">${row.NUMAR_CARTI}</span>
                    </div>
                </div>
            </div>`;
        });
        html += '</div>';
        document.getElementById('tableWrapper').innerHTML = html;
    }
    if (currentTable == 'PACHETE') {
        if (!data || data.length === 0) {
            document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px;">Nu există pachete create.</div>';
            return;
        }

        let html = '<div class="card-grid">';

        data.forEach((row, index) => {
            let deckName = row.NUME_PACHET;
            let deckFormat = row.FORMAT_JOC;
            
            let coverUrl = row.URL_COPERTA || row.url_coperta;
            
            if (!coverUrl || !coverUrl.startsWith('http')) {
                 coverUrl = '/assets/gray.png';
            }

            html += `
            <div class="deck-box-sideways" onclick="selectCardGallery(this, ${index})">
                
                <div class="deck-side-cover" style="background-image: url('${coverUrl}');"></div>
                
                <div class="deck-side-info">
                    <div class="deck-side-name" title="${deckName}">${deckName}</div>
                    <div class="deck-side-format">${deckFormat}</div>
                </div>

            </div>`;
        });

        html += '</div>';
        document.getElementById('tableWrapper').innerHTML = html;
    }
    if (currentTable == 'JUCATORI') {
        if (!data || data.length === 0) {
            document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px;">Nu există jucători înregistrați.</div>';
            return;
        }
        let html = '<div class="card-grid">';
        data.forEach((row, index) => {
            let fullName = `${row.NUME} ${row.PRENUME}`;
            
            let imgSrc = 'assets/avatar.jpg';

            html += `
                <div class="player-card" onclick="selectCardGallery(this, ${index})">
                    
                    <div class="player-avatar-container">
                        <img src="${imgSrc}" class="player-avatar" alt="User Avatar">
                    </div>

                    <div class="player-name">${fullName}</div>
                    
                    <div class="player-detail">
                        <span class="player-label">WOC EMAIL:</span> 
                        <span class="player-value">${row.EMAIL || '-'}</span>
                    </div>
                    
                    <div class="player-detail">
                        <span class="player-label">USERNAME:</span> 
                        <span class="player-value">${row.GAMEID}</span>
                    </div>

                </div>`;
        });
        html += '</div>';
        document.getElementById('tableWrapper').innerHTML = html;
    }
    if(currentTable=='LOCATII'){
        if (!data || data.length === 0) {
            document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px;">Nu există date pentru galerie.</div>';
            return;
        }
        let html = '<div class="locatii-grid">';
        data.forEach((row, index) => {
            let displayTitle = row.NUME_LOCATIE;

            let imgSrc = 'assets/locatie.png';

            html += `
                <div class="player-card" onclick="selectCardGallery(this, ${index})">
                    
                    <div class="player-avatar-container">
                        <img src="${imgSrc}" class="player-avatar" alt="User Avatar">
                    </div>

                    <div class="player-name">${displayTitle}</div>
                    
                    <div class="player-detail">
                        <span class="player-label">ȚARA:</span> 
                        <span class="player-value">${row.TARA}</span>
                    </div>

                    <div class="player-detail">
                        <span class="player-label">ADRESA:</span> 
                        <span class="player-value">${row.ORAS+", "+row.STRADA+", "+row.NUMAR}</span>
                    </div>
                    
                    <div class="player-detail">
                        <span class="player-label">PARTENERIAT:</span> 
                        <span class="player-value">${row.PARTENER_WOTC}</span>
                    </div>

                </div>`;
        });
        html += '</div>';
        document.getElementById('tableWrapper').innerHTML = html;
    }
    if(currentTable=='EVENIMENTE'){
        if (!data || data.length === 0) {
            document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px;">Nu există date pentru galerie.</div>';
            return;
        }
        let html = '<div class="card-grid">';
        data.forEach((row, index) => {
            let displayTitle = row.NUME_EVENIMENT;

            html += `
            <div class="mtg-card event-card" onclick="selectCardGallery(this, ${index})">
                
                <div class="event-title">${displayTitle}</div>
                
                <div class="event-detail">
                    <span class="event-label">DATĂ:</span> 
                    <span class="event-value">${row.DATA_EVENIMENT ? row.DATA_EVENIMENT.split("T")[0] : 'N/A'}</span>
                </div>
            
                <div class="event-detail">
                    <span class="event-label">TIP:</span> 
                    <span class="event-value">${row.TIP}</span>
                </div>

                <div class="event-detail">
                    <span class="event-label">COD_SET:</span> 
                    <span class="event-value">${row.COD_SET}</span>
                </div>

                <div class="event-detail">
                    <span class="event-label">ID_LOCAȚIE:</span> 
                    <span class="event-value">${row.ID_LOCATIE}</span>
                </div>

            </div>`;
        });
        html += '</div>';
        document.getElementById('tableWrapper').innerHTML = html;
    }
    if (currentTable == 'MECIURI') {
        if (!data || data.length === 0) {
            document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px;">Nu există date pentru galerie.</div>';
            return;
        }
        let html = '<div class="card-grid">';
        
        data.forEach((row, index) => {
            let myScore = parseInt(row.JOCURI_CASTIGATE) || 0;
            let oppScore = parseInt(row.JOCURI_PIERDUTE) || 0;
            let round = row.RUNDA || '-';
            let eventId = row.ID_EVENIMENT || 'N/A';
            let matchId = row.ID_MECI;

            let bgColor;
            if (myScore > oppScore) {
                bgColor = '#27ae60';
            } else if (myScore < oppScore) {
                bgColor = '#c0392b';
            } else {
                bgColor = '#ecd138ff';
            }

            html += `
            <div class="match-card" onclick="selectCardGallery(this, ${index})">
                
                <div class="match-header">MECI ${matchId}</div>
                
                <div class="match-score-area">
                    
                    <div class="score-layer layer-bottom" style="background-color: ${bgColor}"></div>
                    
                    <div class="score-layer layer-top" style="background-color: ${bgColor}; top: 2px; left: 2px;"></div>

                    <div class="score-number score-left">
                        ${myScore}
                    </div>
                    
                    <div class="score-number score-right">
                        ${oppScore}
                    </div>
                </div>

                <div class="match-footer">
                    <div class="match-footer-item">
                        <span class="mf-label">RUNDA</span>
                        <span class="mf-val">${round}</span>
                    </div>
                    <div class="match-footer-item">
                        <span class="mf-label">EVENIMENT</span>
                        <span class="mf-val">#${eventId}</span>
                    </div>
                </div>

            </div>`;
        });
        
        html += '</div>';
        document.getElementById('tableWrapper').innerHTML = html;
        return;
    }
}

function selectCardGallery(el, index) {
    const previouslySelected = document.querySelectorAll('.selected');
    
    previouslySelected.forEach(item => {
        item.classList.remove('selected');
    });

    el.classList.add('selected');

    if (currentData && currentData[index]) {
        selectedRow = currentData[index];
        updateButtons();
    }
}

async function loadPortfolioView(btnElement) {
    document.querySelector('.btn-add').disabled = false; 
    currentTable = 'V_PORTOFOLIU_RARE';
    selectedRow = null;
    updateButtons();
    
    document.getElementById('viewModeActions').style.display = 'none';

    document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
    if(btnElement) btnElement.classList.add('active');

    document.getElementById('tableTitle').innerText = "PORTOFOLIU CARTI VALOROASE";
    document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px; color:#aaa;">Filtering high-value assets...</div>';

    try {
        const res = await fetch(`http://localhost:3000/api/table/V_PORTOFOLIU_RARE`);
        if (!res.ok) throw new Error(await res.text());
        const data = await res.json();
        currentData = data;
        renderTable(data); 
        
    } catch (e) {
        document.getElementById('tableWrapper').innerHTML = `<div class="error-msg"><strong>Eroare la încărcare:</strong> ${e.message}</div>`;
    }
}

async function loadAnalysisView(btnElement) {
    document.querySelector('.btn-add').disabled = false; 
    currentTable = 'V_ANALIZA_PACHETE';
    selectedRow = null;
    updateButtons();

    document.getElementById('viewModeActions').style.display = 'none';

    document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
    if(btnElement) btnElement.classList.add('active');

    document.getElementById('tableTitle').innerText = "ANALIZĂ STATISTICĂ PACHETE";
    document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px; color:#aaa;">Calculam Statistici...</div>';

    try {
        const res = await fetch(`http://localhost:3000/api/table/V_ANALIZA_PACHETE`);
        if (!res.ok) throw new Error(await res.text());
        const data = await res.json();
        currentData = data;
        renderAnalysisTable(data); 
        
    } catch (e) {
        document.getElementById('tableWrapper').innerHTML = `<div class="error-msg"><strong>Eroare analiză:</strong> ${e.message}</div>`;
    }
}

function renderAnalysisTable(data) {
    if (!data || data.length === 0) {
        document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px; color:#aaa;">Nu exista date.</div>';
        return;
    }

    const cols = Object.keys(data[0]);
    let html = '<table class="analysis-table"><thead><tr>';
    
    cols.forEach(c => html += `<th>${c.replace(/_/g, ' ')}</th>`);
    html += '</tr></thead><tbody>';

    data.forEach((row, index) => {
        html += `<tr onclick="selectRow(this, ${index})">`; 
        
        cols.forEach(col => {
            let val = row[col];

            if (col === 'MEDIA_MANA_COST') {
                const num = parseFloat(val);
                let color = '#ccc';
                val = `<span style="font-weight:bold; color:${color}">${val}</span>`;
            }

            html += `<td>${val}</td>`;
        });
        html += '</tr>';
    });
    html += '</tbody></table>';
    
    document.getElementById('tableWrapper').innerHTML = html;
}

async function loadWinrateReport(btnElement) {
    document.querySelector('.btn-add').disabled = true; 
    currentTable = 'WINRATE_REPORT';
    selectedRow = null;
    updateButtons(); 
    
    document.getElementById('viewModeActions').style.display = 'none';

    document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
    if(btnElement) btnElement.classList.add('active');

    document.getElementById('tableTitle').innerText = "CAȘTIGURI PACHETE";
    document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px; color:#aaa;">Calculating probabilities...</div>';

    try {
        const res = await fetch(`http://localhost:3000/api/reports/winrate`);
        if (!res.ok) throw new Error(await res.text());
        const data = await res.json();
        renderWinrateTable(data);
    } catch (e) {
        document.getElementById('tableWrapper').innerHTML = `<div class="error-msg"><strong>Calculăm erorile...</strong> ${e.message}</div>`;
    }
}

async function loadHavingReport(btnElement) {
    document.querySelector('.btn-add').disabled = true; 
    currentTable = 'RARITY_DISTRIBUTION_REPORT';
    selectedRow = null;
    updateButtons();

    document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
    if(btnElement) btnElement.classList.add('active');

    const viewActions = document.getElementById('viewModeActions');
    if(viewActions) viewActions.style.display = 'none';

    document.getElementById('tableTitle').innerText = "Distribuție Rarități";
    document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px; color:#aaa;">Calculăm statisticile...</div>';

    try {
        const res = await fetch('http://localhost:3000/api/reports/rarity-distribution');
        if (!res.ok) throw new Error(await res.text());
        const data = await res.json();

        renderHavingTable(data); 

    } catch (e) {
        document.getElementById('tableWrapper').innerHTML = `<div class="error-msg">Error: ${e.message}</div>`;
    }
}

function renderHavingTable(data) {
    if (!data || data.length === 0) {
        document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px; color:#aaa;">No data found.</div>';
        return;
    }
    const cols = Object.keys(data[0]);
    let html = '<table><thead><tr>';
    
    cols.forEach(c => html += `<th>${c}</th>`); 
    
    html += '</tr></thead><tbody>';
    
    data.forEach(row => {
        html += `<tr>`; 
        
        cols.forEach(c => {
            let val = row[c] !== null ? row[c] : '';
            
            if (typeof val === 'string' && val.includes('T') && /^\d{4}-\d{2}-\d{2}T/.test(val)) {
                val = val.split('T')[0];
            }
            
            html += `<td>${val}</td>`;
        });
        html += '</tr>';
    });
    html += '</tbody></table>';
    document.getElementById('tableWrapper').innerHTML = html;
}

function renderWinrateTable(data) {
    if (!data || data.length === 0) {
        document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px; color:#aaa;">Nu se gasesc date.</div>';
        return;
    }
    const cols = Object.keys(data[0]);
    let html = '<table><thead><tr>';
    cols.forEach(c => html += `<th>${c}</th>`);
    html += '</tr></thead><tbody>';
    data.forEach(row => {
        html += `<tr>`;
        cols.forEach(col => {
            let val = row[col];
            if (col === 'WINRATE') {
                const numericVal = parseFloat(val);
                let color = '#d3202a'; 
                if (numericVal >= 50) color = '#e67e22'; 
                if (numericVal >= 60) color = '#27ae60'; 
                val = `<strong style="color: ${color}">${val}</strong>`;
            }
            html += `<td>${val}</td>`;
        });
        html += '</tr>';
    });
    html += '</tbody></table>';
    document.getElementById('tableWrapper').innerHTML = html;
}

function selectRow(tr, index) {
    const prev = document.querySelector('tr.selected');
    if (prev) prev.classList.remove('selected');
    tr.classList.add('selected');
    selectedRow = currentData[index];
    updateButtons();
}

function updateButtons() {
    const active = selectedRow !== null;
    document.getElementById('btnEdit').disabled = !active;
    document.getElementById('btnDelete').disabled = !active;
}

function openModal(mode) {
    if (currentData.length === 0 && mode === 'add') {
        alert("Nu pot deduce structura tabelului gol."); return;
    }
    currentMode = mode;
    const container = document.getElementById('modalFormBody');
    container.innerHTML = '';
    
    const keys = (mode === 'edit') ? Object.keys(selectedRow) : Object.keys(currentData[0]);
    const pkKey = keys[0]; 

    document.getElementById('modalTitle').innerText = (mode === 'add') ? `Adauga la ${currentTable}` : `Editeaza la ${currentTable}`;

    keys.forEach(key => {
        let val = '';
        if (mode === 'edit') val = selectedRow[key] !== null ? selectedRow[key] : '';
        const isReadOnly = /*(mode === 'edit' && key === pkKey)*/null;

        const div = document.createElement('div');
        div.className = 'form-group';
        div.innerHTML = `
            <label>${key}</label>
            <input type="text" id="input_${key}" value="${val}" ${isReadOnly ? 'readonly' : ''} autocomplete="off">
        `;
        container.appendChild(div);
    });
    document.getElementById('unifiedModal').style.display = 'flex';
}

function closeModal() {
    document.getElementById('unifiedModal').style.display = 'none';
}

async function saveData() {
    const keys = Object.keys(currentData[0]);
    const newData = {};
    
    keys.forEach(key => {
        newData[key] = document.getElementById(`input_${key}`).value;
    });

    if (currentMode === 'edit') {
        const pkCol = keys[0];
        const oldPkVal = selectedRow[pkCol];
        await updateData(newData, pkCol, oldPkVal);
    } else {
        await insertData(newData);
    }
}

async function updateData(data, pkCol, oldPkVal) {
    try {
        const res = await fetch(`http://localhost:3000/api/update/generic`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ 
                tableName: currentTable, 
                pkCol: pkCol, 
                pkVal: oldPkVal,
                data: data
            })
        });
        const json = await res.json();
        
        if(json.success) { 
            closeModal(); 
            loadTable(currentTable, document.querySelector('.nav-btn.active')); 
        }
        else {
            alert("NU SE POATE MODIFICA:\n" + json.error);
        }
    } catch(e) { 
        alert("Eroare de rețea: " + e); 
    }
}

async function insertData(data) {
    try {
        const res = await fetch(`http://localhost:3000/api/insert/generic`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ tableName: currentTable, data: data })
        });
        const json = await res.json();
        if(json.success) { closeModal(); loadTable(currentTable, document.querySelector('.nav-btn.active')); }
        else alert("EROARE: " + json.error);
    } catch(e) { alert(e); }
}

async function deleteItem() {
    if(!selectedRow || !confirm('Șterge această entitate?')) return;
    const idCol = Object.keys(selectedRow)[0];
    const idVal = selectedRow[idCol];
    try {
        const res = await fetch(`http://localhost:3000/api/delete/${currentTable}/${idCol}/${idVal}`, { method: 'DELETE' });
        const json = await res.json();
        if(json.success) loadTable(currentTable, document.querySelector('.nav-btn.active'));
        else alert('Counterspell: ' + (json.error || JSON.stringify(json)));
    } catch(e) { alert(e); }
}

let sortAsc = true;
function sortTable(col) {
    sortAsc = !sortAsc;
    currentData.sort((a, b) => {
        let v1 = a[col], v2 = b[col];
        if (typeof v1 === 'string') v1 = v1.toLowerCase();
        if (typeof v2 === 'string') v2 = v2.toLowerCase();
        if (v1 < v2) return sortAsc ? -1 : 1;
        if (v1 > v2) return sortAsc ? 1 : -1;
        return 0;
    });
    renderCurrentView();
}

window.onclick = function(event) {
    const modal = document.getElementById('unifiedModal');
    if (event.target == modal) closeModal();
}

// --- FUNCȚII SCRYFALL IMPORT ---

function openScryfallModal() {
    document.getElementById('scryfallModal').style.display = 'flex';
    document.getElementById('sf_cardName').value = '';
    document.getElementById('sf_setCode').value = '';
    document.getElementById('sf_preview').style.display = 'none';
}

function closeScryfallModal() {
    document.getElementById('scryfallModal').style.display = 'none';
}

async function searchAndImportScryfall() {
    const name = document.getElementById('sf_cardName').value.trim();
    const setCode = document.getElementById('sf_setCode').value.trim().toUpperCase();

    if (!name) {
        alert("Te rog introdu un nume de carte.");
        return;
    }

    let url = `https://api.scryfall.com/cards/named?fuzzy=${encodeURIComponent(name)}`;
    if (setCode) {
        url += `&set=${setCode}`;
    }

    document.getElementById('sf_foundName').innerText = "Căutăm pe Scryfall...";
    document.getElementById('sf_preview').style.display = 'block';

    try {
        const res = await fetch(url);
        if (!res.ok) {
            throw new Error("Cartea nu a fost găsită pe Scryfall (sau setul e greșit).");
        }
        const sfData = await res.json();

        const checkSetRes = await fetch(`http://localhost:3000/api/table/SETURI`);
        const allSets = await checkSetRes.json();
        
        const foundSetCode = sfData.set.toUpperCase();
        
        const setExists = allSets.some(s => s.COD_SET === foundSetCode);

        document.getElementById('sf_foundName').innerText = sfData.name;
        document.getElementById('sf_foundSet').innerText = `Set: ${foundSetCode}`;
        if(sfData.image_uris) {
            document.getElementById('sf_img').src = sfData.image_uris.small;
        }

        if (!setExists) {
            alert(`EROARE: Cartea găsită aparține setului '${foundSetCode}', dar acest set NU există în baza ta de date!\n\nTe rog adaugă întâi setul '${foundSetCode}' sau caută o versiune a cărții dintr-un set pe care îl ai.`);
            return;
        }

        const oracleData = {
            NUME_CARTE: sfData.name,
            COST_MANA: sfData.cmc || 0,
            RARITATE: sfData.rarity,
            LINIE_TIP: sfData.type_line,
            DESCRIERE: sfData.oracle_text || "No text",
            URL_IMAGINE: sfData.image_uris ? sfData.image_uris.normal : 'No Image',
            PUTERE: parseInt(sfData.power) || null,
            DURITATE: parseInt(sfData.toughness) || null,
            LOIALITATE: parseInt(sfData.loyalty) || null,
            APARARE: parseInt(sfData.defense) || null,
            NUMAR_DETINUT: 0
        };

        // Confirmare utilizator
        if(!confirm(`Am găsit: ${sfData.name} (${foundSetCode}). Importăm?`)) return;

        // Inserăm în CARTI
        await insertDataGeneric('CARTI', oracleData);

        // Inserăm în CARTI_SETURI legătura
        const linkData = {
            COD_SET: foundSetCode,
            NUME_CARTE: sfData.name,
            NUMAR_COPII: 0
        };
        await insertDataGeneric('CARTI_SETURI', linkData);

        alert("Carte importată cu succes!");
        closeScryfallModal();
        loadTable('CARTI', document.querySelector('.nav-btn.active'));

    } catch (e) {
        alert("Eroare: " + e.message);
        document.getElementById('sf_foundName').innerText = "Eroare";
    }
}

async function insertDataGeneric(tableName, dataObj) {
    const res = await fetch(`http://localhost:3000/api/insert/generic`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ tableName: tableName, data: dataObj })
    });
    const json = await res.json();
    if (!json.success) throw new Error(json.error);
}

function openScryfallSetModal() {
    document.getElementById('scryfallSetModal').style.display = 'flex';
    document.getElementById('sf_setCodeInput').value = '';
    document.getElementById('sf_set_preview').style.display = 'none';
    setTimeout(() => document.getElementById('sf_setCodeInput').focus(), 100);
}

function closeScryfallSetModal() {
    document.getElementById('scryfallSetModal').style.display = 'none';
}

async function fetchAndImportSet() {
    const codeInput = document.getElementById('sf_setCodeInput').value.trim();
    
    if (!codeInput) {
        alert("Introduceți un cod de set (ex: ONE).");
        return;
    }

    const url = `https://api.scryfall.com/sets/${codeInput}`;
    
    document.getElementById('sf_setFoundName').innerText = "Căutăm...";
    document.getElementById('sf_set_preview').style.display = 'block';

    try {
        const res = await fetch(url);
        if (!res.ok) {
            throw new Error("Setul nu a fost găsit. Verifică codul (ex: NEO, WOE).");
        }
        const sfData = await res.json();

        document.getElementById('sf_setFoundName').innerText = sfData.name;
        document.getElementById('sf_setReleased').innerText = sfData.released_at;
        document.getElementById('sf_setCount').innerText = sfData.card_count;
        document.getElementById('sf_setIcon').src = sfData.icon_svg_uri;

        const checkRes = await fetch(`http://localhost:3000/api/table/SETURI`);
        const existingSets = await checkRes.json();
        const exists = existingSets.some(s => s.COD_SET === sfData.code.toUpperCase());

        if (exists) {
            alert(`Setul ${sfData.code.toUpperCase()} există deja în baza de date!`);
            return;
        }

        if(!confirm(`Importăm setul "${sfData.name}"?`)) return;

        const oracleSetData = {
            COD_SET: sfData.code.toUpperCase(),
            NUME_SET: sfData.name,
            DATA_LANSARE: sfData.released_at,
            NUMAR_CARTI: sfData.card_count,
            URL_IMAGINE_SET: sfData.icon_svg_uri || 'https://svgs.scryfall.io/sets/default.svg'
        };

        await insertDataGeneric('SETURI', oracleSetData);

        alert("Set importat cu succes!");
        closeScryfallSetModal();
        loadTable('SETURI', document.querySelector('.nav-btn.active'));

    } catch (e) {
        alert("Eroare: " + e.message);
        document.getElementById('sf_setFoundName').innerText = "Eroare";
    }
}