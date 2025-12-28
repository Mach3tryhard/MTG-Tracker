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

    currentTable = tableName;
    selectedRow = null;
    updateButtons();

    if (btnElement) {
        document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
        btnElement.classList.add('active');
    }

    const titleEl = document.getElementById('tableTitle');
    if(titleEl) titleEl.innerText = tableName;
    
    const viewActions = document.getElementById('viewModeActions');
    if(viewActions) viewActions.style.display = 'flex';
    

    document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px; color:#aaa;">Se caută datele...</div>';

    try {
        const res = await fetch(`http://localhost:3000/api/table/${tableName}`);
        if (!res.ok) throw new Error(await res.text());
        const data = await res.json();
        currentData = data;
        
        renderCurrentView(); 
        
    } catch (e) {
        document.getElementById('tableWrapper').innerHTML = `<div class="error-msg"><strong>Fizzle Error:</strong> ${e.message}</div>`;
    }
}


function switchView(mode) {
    currentViewMode = mode;
    updateViewButtonsUI();
    
    renderCurrentView();
    
    selectedRow = null;
    updateButtons();
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

// --- RENDERIZARE TABEL STANDARD ---
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

// --- RENDERIZARE GALERIE (NOU) ---
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
                    <img src="${imgSrc}" onerror="this.src='https://gatherer.wizards.com/Handlers/Image.ashx?type=card&name=Card+Back'">
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
            let displayTitle = row.NUME_SET;

            html += `
            <div class="mtg-card set-card" onclick="selectCardGallery(this, ${index})">
                
                <div class="set-title">${displayTitle}</div>
                
                <div class="set-detail">
                    <span class="set-label">COD:</span> 
                    <span class="set-value">${row.COD_SET}</span>
                </div>
                
                <div class="set-detail">
                    <span class="set-label">LANSARE:</span> 
                    <span class="set-value">${row.DATA_LANSARE ? row.DATA_LANSARE.split("T")[0] : 'N/A'}</span>
                </div>
                
                <div class="set-detail">
                    <span class="set-label">TOTAL:</span> 
                    <span class="set-value">${row.NUMAR_CARTI}</span>
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
            
            // Imaginea de copertă
            let coverImg = 'cover.jpg';

            html += `
            <div class="deck-scene" onclick="selectCardGallery(this, ${index})">
                <div class="deck-box">
                    <div class="deck-face-front" style="background-image: url('${coverImg}');"></div>
                    
                    <div class="deck-banner">
                        <div class="deck-name">${deckName}</div>
                        <div class="deck-format">${deckFormat}</div>
                    </div>
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
            
            let imgSrc = 'avatar.jpg';

            html += `
                <div class="mtg-card player-card" onclick="selectCardGallery(this, ${index})">
                    
                    <div class="player-avatar-container">
                        <img src="${imgSrc}" class="player-avatar" alt="User Avatar">
                    </div>

                    <div class="player-name">${fullName}</div>
                    
                    <div class="player-detail">
                        <span class="player-label">EMAIL:</span> 
                        <span class="player-value">${row.EMAIL || '-'}</span>
                    </div>
                    
                    <div class="player-detail">
                        <span class="player-label">GAMEID:</span> 
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

            html += `
            <div class="mtg-card set-card" onclick="selectCardGallery(this, ${index})">
                
                <div class="set-title">${displayTitle}</div>
                
                <div class="set-detail">
                    <span class="set-label">ADRESĂ:</span> 
                    <span class="set-value">${row.TARA+", "+row.ORAS+", "+row.STRADA+", "+row.NUMAR}</span>
                </div>
                
                <div class="set-detail">
                    <span class="set-label">PARTENERIAT:</span> 
                    <span class="set-value">${row.PARTENER_WOTC}</span>
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
            <div class="mtg-card set-card" onclick="selectCardGallery(this, ${index})">
                
                <div class="set-title">${displayTitle}</div>
                
                <div class="set-detail">
                    <span class="set-label">DATĂ:</span> 
                    <span class="set-value">${row.DATA_EVENIMENT ? row.DATA_EVENIMENT.split("T")[0] : 'N/A'}</span>
                </div>
                
                <div class="set-detail">
                    <span class="set-label">TIP:</span> 
                    <span class="set-value">${row.TIP}</span>
                </div>

                <div class="set-detail">
                    <span class="set-label">COD_SET & ID_LOCAȚIE:</span> 
                    <span class="set-value">${row.ID_LOCATIE+","+row.COD_SET}</span>
                </div>

            </div>`;
        });
        html += '</div>';
        document.getElementById('tableWrapper').innerHTML = html;
    }
    if(currentTable=='MECIURI'){
        if (!data || data.length === 0) {
            document.getElementById('tableWrapper').innerHTML = '<div style="padding:20px;">Nu există date pentru galerie.</div>';
            return;
        }
        let html = '<div class="meciuri-grid">';
        data.forEach((row, index) => {

            html += `
            <div class="mtg-card set-card" onclick="selectCardGallery(this, ${index})">
                
                <div class="set-title"> MECI ${row.ID_MECI}</div>
                
                <div class="set-detail">
                    <span class="set-label">SCOR: </span> 
                    <span class="set-value">${row.JOCURI_CASTIGATE+" la " + row.JOCURI_PIERDUTE}</span>
                </div>
                
                <div class="set-detail">
                    <span class="set-label">REZULTAT:</span> 
                    <span style="${row.JOCURI_CASTIGATE<row.JOCURI_PIERDUTE ? "color:red;" : "color:green;"} font-family: monospace; font-size: 1rem;">${row.JOCURI_CASTIGATE<row.JOCURI_PIERDUTE ? "PIERDUT" : "CASTIGAT"}</span>
                </div>

                <div class="set-detail">
                    <span class="set-label">RUNDA:</span> 
                    <span class="set-value">${row.RUNDA}</span>
                </div>

                <div class="set-detail">
                    <span class="set-label">EVENIMENTUL: </span> 
                    <span class="set-value">${row.ID_EVENIMENT}</span>
                </div>

            </div>`;
        });
        html += '</div>';
        document.getElementById('tableWrapper').innerHTML = html;
    }
}

function selectCardGallery(el, index) {
    document.querySelectorAll('.mtg-card.selected').forEach(d => d.classList.remove('selected'));
    el.classList.add('selected');
    selectedRow = currentData[index];
    updateButtons();
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
        const isReadOnly = (mode === 'edit' && key === pkKey);

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
        await updateData(newData, keys[0]);
    } else {
        await insertData(newData);
    }
}

async function updateData(data, pkCol) {
    try {
        const res = await fetch(`http://localhost:3000/api/update/generic`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ tableName: currentTable, pkCol: pkCol, pkVal: data[pkCol], data: data })
        });
        const json = await res.json();
        if(json.success) { closeModal(); loadTable(currentTable, document.querySelector('.nav-btn.active')); }
        else alert("Spell Fizzled: " + json.error);
    } catch(e) { alert(e); }
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
        else alert("Spell Fizzled: " + json.error);
    } catch(e) { alert(e); }
}

async function deleteItem() {
    if(!selectedRow || !confirm('Exile this permanent? (Delete)')) return;
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

