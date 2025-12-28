const express = require('express');
const oracledb = require('oracledb');
const cors = require('cors');
const path = require('path');

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname)));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

/*{
  "user": "user",
  "password": "pass",
  "connectString": "localhost:1521/XEPDB1"
}*/

const dbConfig = require('./login.json');

oracledb.autoCommit = true;

//1 GET THE TABLE
app.get('/api/table/:tableName', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const tableName = req.params.tableName.toUpperCase();
        if (!/^[A-Z0-9_]+$/.test(tableName)) return res.status(400).send("Nume invalid");

        const result = await connection.execute(
            `SELECT * FROM ${tableName}`, [], { outFormat: oracledb.OUT_FORMAT_OBJECT }
        );
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    } finally {
        if (connection) try { await connection.close(); } catch (e) {}
    }
});

//2 UPDATE IN TABLE
app.put('/api/update/generic', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        
        const { tableName, pkCol, pkVal, data } = req.body;

        if (!/^[A-Z0-9_]+$/.test(tableName) || !/^[A-Z0-9_]+$/.test(pkCol)) {
            return res.status(400).json({ error: "Nume tabel/coloană invalide" });
        }

        let setClauses = [];
        let bindParams = {};

        Object.keys(data).forEach(key => {
            if (key !== pkCol) {
                setClauses.push(`${key} = :${key}`);
                bindParams[key] = data[key];
            }
        });

        // Adăugăm valoarea pentru WHERE
        bindParams['pk_val_bind'] = pkVal;

        const sql = `UPDATE ${tableName} SET ${setClauses.join(', ')} WHERE ${pkCol} = :pk_val_bind`;

        console.log("Execut SQL:", sql);
        
        await connection.execute(sql, bindParams);
        res.json({ success: true });

    } catch (err) {
        console.error(err);
        res.status(500).json({ error: err.message });
    } finally {
        if (connection) try { await connection.close(); } catch (e) {}
    }
});

//3 DELETE FROM TABLE
app.delete('/api/delete/:tableName/:idCol/:idVal', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const { tableName, idCol, idVal } = req.params;
        if (!/^[A-Z0-9_]+$/.test(tableName) || !/^[A-Z0-9_]+$/.test(idCol)) return res.status(400).send("Input invalid");

        const sql = `DELETE FROM ${tableName} WHERE ${idCol} = :id`;
        await connection.execute(sql, [idVal]);
        res.json({ success: true });
    } catch (err) {
        res.status(500).json({ error: err.message });
    } finally {
        if (connection) try { await connection.close(); } catch (e) {}
    }
});

//4 INSERT INTO TABLE
app.post('/api/insert/generic', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const { tableName, data } = req.body;

        if (!/^[A-Z0-9_]+$/.test(tableName)) return res.status(400).json({ error: "Nume tabel invalid" });

        let cols = [];
        let vals = [];
        let bindParams = {};

        Object.keys(data).forEach(key => {
            if (data[key] !== "" && data[key] !== null) {
                cols.push(key);
                vals.push(`:${key}`);
                bindParams[key] = data[key];
            }
        });

        const sql = `INSERT INTO ${tableName} (${cols.join(', ')}) VALUES (${vals.join(', ')})`;
        console.log("SQL INSERT:", sql);

        await connection.execute(sql, bindParams);
        res.json({ success: true });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: err.message });
    } finally {
        if (connection) try { await connection.close(); } catch (e) {}
    }
});

// CERINTA C
app.get('/api/reports/winrate', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        
        const sql = `
            SELECT 
            p.NUME_PACHET,
            p.FORMAT_JOC,
            COUNT(m.ID_MECI) as MECIURI_JUCATE,
            SUM(CASE WHEN m.JOCURI_CASTIGATE > m.JOCURI_PIERDUTE THEN 1 ELSE 0 END) as VICTORII,
            SUM(CASE WHEN m.JOCURI_PIERDUTE > m.JOCURI_CASTIGATE THEN 1 ELSE 0 END) as INFRANGERI,
            ROUND((SUM(CASE WHEN m.JOCURI_CASTIGATE > m.JOCURI_PIERDUTE THEN 1.0 ELSE 0.0 END) / COUNT(m.ID_MECI)) * 100, 1) || '%' as PROCENT_VICTORII
        FROM PACHETE p
        JOIN PACHETE_MECIURI pm ON p.ID_PACHET = pm.ID_PACHET
        JOIN MECIURI m ON pm.ID_MECI = m.ID_MECI
        WHERE p.FORMAT_JOC = 'sealed'
        GROUP BY p.NUME_PACHET, p.FORMAT_JOC
        ORDER BY VICTORII DESC
        `;

        const result = await connection.execute(sql, [], { outFormat: oracledb.OUT_FORMAT_OBJECT });
        res.json(result.rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: err.message });
    } finally {
        if (connection) try { await connection.close(); } catch (e) {}
    }
});

app.listen(3000, () => {
    console.log('Serverul ruleaza pe 3000...');
});

// CERINTA D 
app.get('/api/reports/rarity-distribution', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);

        const sql = `
            SELECT 
                raritate AS "RARITATE", 
                COUNT(*) AS "NUMAR_CARTI" 
            FROM carti 
            GROUP BY raritate 
            HAVING COUNT(*) >= 1
            ORDER BY COUNT(*) DESC
        `;
        
        const result = await connection.execute(sql, [], { outFormat: oracledb.OUT_FORMAT_OBJECT });

        res.json(result.rows);

    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Eroare raport HAVING: " + err.message });
    } finally {
        if (connection) try { await connection.close(); } catch (e) {}
    }
});