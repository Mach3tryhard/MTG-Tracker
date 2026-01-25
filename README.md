# MTG-Tracker

![Oracle Database](https://img.shields.io/badge/Database-Oracle-F80000?style=for-the-badge&logo=oracle)
![SQL](https://img.shields.io/badge/Language-SQL-blue?style=for-the-badge&logo=postgresql)
![Status](https://img.shields.io/badge/Status-Educational-green?style=for-the-badge)

**MTG-Tracker** este o aplicație de tip bază de date destinată gestionării colecțiilor de cărți *Magic: The Gathering*, a pachetelor de joc (decks) și a seturilor (edițiilor). Proiectul demonstrează utilizarea avansată a **Oracle SQL** pentru manipularea datelor, generarea de rapoarte și menținerea integrității referențiale.

##  Descriere

Acest proiect a fost dezvoltat pentru a simula un sistem real de inventariere a cărților de joc. Baza de date permite utilizatorilor să țină evidența cărților deținute, să construiască pachete virtuale și să analizeze statistici legate de raritate, preț sau cost de mană (CMC), folosind funcționalități specifice Oracle.

## 🛠️ Structura Bazei de Date

Proiectul este construit pe o schemă relațională robustă, incluzând tabele precum:

* **CARTI**: Stochează detaliile de bază (Nume, Cost Mana, Tip, Text).
* **SETURI**: Informații despre edițiile lansate (Data lansării, Simbol).
* **CARTI_SETURI**: Tabel de asociere (Many-to-Many) care leagă cărțile de edițiile în care au fost tipărite și specifică raritatea.
* **PACHETE**: Gestionarea deck-urilor create de utilizatori.
* **INVENTAR**: Cantitatea deținută pentru fiecare carte.

## Funcționalități Cheie

* **Interogări Complexe**: Utilizarea jonctiunilor multiple (JOIN), subcereri corelate și funcții de agregare (`GROUP BY`, `HAVING`) pentru rapoarte detaliate.
* **Vederi (Views)**: Implementarea vizualizărilor (ex: `V_CARTI_SI_EDITII`) pentru a simplifica accesul la datele agregate din tabelele de legătură.
* **Analiză de Date**:
    * Calculul costului mediu de mană per pachet.
    * Identificarea celor mai valoroase cărți din colecție.
    * Statistici privind distribuția culorilor în pachete.
* **Integritate**: Constrângeri (PK, FK, CHECK) pentru validarea datelor introduse.

## Tehnologii Folosite

* **SGBD**: Oracle Database (11g/12c/19c sau XE).
* **Limbaje**: SQL, PL/SQL.
* **Tools**: SQL Developer / DataGrip.

## Cum se rulează

1.  Asigurați-vă că aveți acces la o instanță Oracle Database.
2.  Clonați acest repository.
3.  Rulați scriptul de creare a tabelelor: `create_schema.sql`.
4.  Rulați scriptul de populare a datelor: `insert_data.sql`.
5.  Testați interogările din fișierul `queries.sql`.

## Autori

* **[Mach3tryhard](https://github.com/Mach3tryhard)** - *Dezvoltator & Design Bază de Date*
