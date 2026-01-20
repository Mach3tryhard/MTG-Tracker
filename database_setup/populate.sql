DELETE FROM PACHETE_MECIURI;
DELETE FROM MECIURI_JUCATORI;
DELETE FROM PACHETE_CARTI;
DELETE FROM CARTI_SETURI;
DELETE FROM MECIURI;
DELETE FROM EVENIMENTE;
DELETE FROM JUCATORI;
DELETE FROM PACHETE;
DELETE FROM LOCATII;
DELETE FROM CARTI;
DELETE FROM SETURI;

ALTER TABLE PACHETE MODIFY (ID_PACHET GENERATED AS IDENTITY (RESTART START WITH 1));
ALTER TABLE LOCATII MODIFY (ID_LOCATIE GENERATED AS IDENTITY (RESTART START WITH 1));
ALTER TABLE JUCATORI MODIFY (ID_JUCATOR GENERATED AS IDENTITY (RESTART START WITH 1));
ALTER TABLE EVENIMENTE MODIFY (ID_EVENIMENT GENERATED AS IDENTITY (RESTART START WITH 1));
ALTER TABLE MECIURI MODIFY (ID_MECI GENERATED AS IDENTITY (RESTART START WITH 1));

COMMIT;

-- 1. SETURI
INSERT INTO SETURI (COD_SET, NUME_SET, DATA_LANSARE, NUMAR_CARTI, URL_IMAGINE_SET) 
VALUES ('TDM', 'Tarkir: Dragonstorm', DATE '2025-04-11', 427,'https://svgs.scryfall.io/sets/tdm.svg?1766379600');
INSERT INTO SETURI (COD_SET, NUME_SET, DATA_LANSARE, NUMAR_CARTI, URL_IMAGINE_SET) 
VALUES ('EOE', 'Edge of Eternities', DATE '2025-08-01', 399,'https://svgs.scryfall.io/sets/eoe.svg?1766379600');
INSERT INTO SETURI (COD_SET, NUME_SET, DATA_LANSARE, NUMAR_CARTI, URL_IMAGINE_SET) 
VALUES ('SPM', 'Marvels Spider-Man', DATE '2025-09-26', 286,'https://svgs.scryfall.io/sets/spm.svg?1766379600');
INSERT INTO SETURI (COD_SET, NUME_SET, DATA_LANSARE, NUMAR_CARTI, URL_IMAGINE_SET) 
VALUES ('BLB', 'Bloomburrow', DATE '2024-08-02', 398,'https://svgs.scryfall.io/sets/blb.svg?1766379600');
INSERT INTO SETURI (COD_SET, NUME_SET, DATA_LANSARE, NUMAR_CARTI, URL_IMAGINE_SET) 
VALUES ('MH3', 'Modern Horizons 3', DATE '2024-06-14', 528,'https://svgs.scryfall.io/sets/mh3.svg?1766379600');
INSERT INTO SETURI (COD_SET, NUME_SET, DATA_LANSARE, NUMAR_CARTI, URL_IMAGINE_SET) 
VALUES ('OTJ', 'Outlaws of Thunder Junction', DATE '2024-04-19', 374,'https://svgs.scryfall.io/sets/otj.svg?1766379600');
INSERT INTO SETURI (COD_SET, NUME_SET, DATA_LANSARE, NUMAR_CARTI, URL_IMAGINE_SET) 
VALUES ('RVR', 'Ravnica Remastered', DATE '2024-01-12', 531,'https://svgs.scryfall.io/sets/rvr.svg?1766379600');
INSERT INTO SETURI (COD_SET, NUME_SET, DATA_LANSARE, NUMAR_CARTI, URL_IMAGINE_SET) 
VALUES ('LCI', 'The Lost Caverns of Ixalan', DATE '2023-11-17', 416,'https://svgs.scryfall.io/sets/lci.svg?1766379600');
INSERT INTO SETURI (COD_SET, NUME_SET, DATA_LANSARE, NUMAR_CARTI, URL_IMAGINE_SET) 
VALUES ('WOE', 'Wilds of Eldraine', DATE '2023-09-08', 381,'https://svgs.scryfall.io/sets/woe.svg?1766379600');
INSERT INTO SETURI (COD_SET, NUME_SET, DATA_LANSARE, NUMAR_CARTI, URL_IMAGINE_SET) 
VALUES ('LTR', 'The Lord of the Rings: Tales of Middle-earth', DATE '2023-06-23', 856,'https://svgs.scryfall.io/sets/ltr.svg?1766379600');

-- 2. CARTI
-- TDM
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Ugin, Eye of the Storms', 7, 'mythic', 'Legendary Planeswalker — Ugin', 'When you cast this spell, exile up to one target permanent that`s one or more colors.
Whenever you cast a colorless spell, exile up to one target permanent that`s one or more colors.
+2: You gain 3 life and draw a card.
0: Add {C}{C}{C}.
−11: Search your library for any number of colorless nonland cards, exile them, then shuffle. Until end of turn, you may cast those cards without paying their mana costs.', 'https://cards.scryfall.io/large/front/6/4/64a5d494-efa1-446b-bebe-2ad36e154376.jpg?1761770162', NULL, NULL, 7, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Anafenza, Unyielding Lineage', 3, 'rare', 'Legendary Creature — Spirit Soldier', 'Flash
First strike
Whenever another nontoken creature you control dies, Anafenza endures 2. (Put two +1/+1 counters on it or create a 2/2 white Spirit creature token.)', 'https://cards.scryfall.io/large/front/2/9/29957f49-9a6b-42f6-b2fb-b48f653ab725.jpg?1743203958', 2, 2, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Arashin Sunshield', 4, 'common', 'Creature — Human Warrior', 'When this creature enters, exile up to two target cards from a single graveyard.
{W}, {T}: Tap target creature.', 'https://cards.scryfall.io/large/front/d/d/dd7102d8-90b3-45a1-b66d-dcca469b1fb6.jpg?1743697519', 3, 4, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Bearer of Glory', 2, 'common', 'Creature — Human Soldier', 'During your turn, this creature has first strike.
{4}{W}: Creatures you control get +1/+1 until end of turn.', 'https://cards.scryfall.io/large/front/d/6/d6d91e42-43db-428d-a4dd-ef9d40306314.jpg?1743203967', 2, 1, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Clarion Conqueror', 3, 'rare', 'Creature — Dragon', 'Flying
Activated abilities of artifacts, creatures, and planeswalkers can`t be activated.', 'https://cards.scryfall.io/large/front/f/8/f892d156-371c-4391-8ae6-25513c5032b0.jpg?1761770058', 3, 3, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Coordinated Maneuver', 2, 'common', 'Instant', 'Choose one —
• Coordinated Maneuver deals damage equal to the number of creatures you control to target creature or planeswalker.
• Destroy target enchantment.', 'https://cards.scryfall.io/large/front/c/6/c6569487-53c5-4b91-877d-e4e31bfa90c0.jpg?1743203976', NULL, NULL, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Dalkovan Packbeasts', 3, 'uncommon', 'Creature — Ox', 'Vigilance
Mobilize 3 (Whenever this creature attacks, create three tapped and attacking 1/1 red Warrior creature tokens. Sacrifice them at the beginning of the next end step.)', 'https://cards.scryfall.io/large/front/4/d/4df7b253-6107-47d6-b650-cb4d3e0aec6b.jpg?1743203980', 0, 4, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Descendant of Storms', 1, 'uncommon', 'Creature — Human Soldier', 'Whenever this creature attacks, you may pay {1}{W}. If you do, it endures 1. (Put a +1/+1 counter on it or create a 1/1 white Spirit creature token.)', 'https://cards.scryfall.io/large/front/f/6/f632be90-9e7f-41f8-a52e-a2952354d730.jpg?1743203984', 2, 1, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Dragonback Lancer', 4, 'common', 'Creature — Human Soldier', 'Flying
Mobilize 1 (Whenever this creature attacks, create a tapped and attacking 1/1 red Warrior creature token. Sacrifice it at the beginning of the next end step.)', 'https://cards.scryfall.io/large/front/0/2/0200a8c5-3293-48d0-a523-ba148680f588.jpg?1743203987', 3, 3, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Duty Beyond Death', 2, 'uncommon', 'Instant', 'As an additional cost to cast this spell, sacrifice a creature.
Creatures you control gain indestructible until end of turn. Put a +1/+1 counter on each creature you control. (Damage and effects that say "destroy" don`t destroy those creatures.)', 'https://cards.scryfall.io/large/front/2/e/2e92640d-768b-4357-905f-bea017d351cc.jpg?1743203993', NULL, NULL, NULL, NULL, 1);
-- EOE
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Anticausal Vestige', 6, 'rare', 'Creature — Eldrazi', 'When this creature leaves the battlefield, draw a card, then you may put a permanent card with mana value less than or equal to the number of lands you control from your hand onto the battlefield tapped.
Warp {4} (You may cast this card from your hand for its warp cost. Exile this creature at the beginning of the next end step, then you may cast it from exile on a later turn.)', 'https://cards.scryfall.io/large/front/3/5/35372b69-6086-44e0-9f7c-681e362e5142.jpg?1752946556', 7, 5, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Tezzeret, Cruel Captain', 3, 'mythic', 'Legendary Planeswalker — Tezzeret', 'Whenever an artifact you control enters, put a loyalty counter on Tezzeret.
0: Untap target artifact or creature. If it`s an artifact creature, put a +1/+1 counter on it.
−3: Search your library for an artifact card with mana value 1 or less, reveal it, put it into your hand, then shuffle.
−7: You get an emblem with "At the beginning of combat on your turn, put three +1/+1 counters on target artifact you control. If it`s not a creature, it becomes a 0/0 Robot artifact creature."', 'https://cards.scryfall.io/large/front/0/2/02e8e540-8aa3-4e6a-9a11-c3949cab5f0f.jpg?1754473212', NULL, NULL, 4, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('All-Fates Stalker', 4, 'uncommon', 'Creature — Drix Assassin', 'When this creature enters, exile up to one target non-Assassin creature until this creature leaves the battlefield.
Warp {1}{W} (You may cast this card from your hand for its warp cost. Exile this creature at the beginning of the next end step, then you may cast it from exile on a later turn.)', 'https://cards.scryfall.io/large/front/8/2/82ae4f7b-8122-4af6-8079-888eabf1a11e.jpg?1752946565', 2, 3, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Astelli Reclaimer', 5, 'rare', 'Creature — Angel Warrior', 'Flying
When this creature enters, return target noncreature, nonland permanent card with mana value X or less from your graveyard to the battlefield, where X is the amount of mana spent to cast this creature.
Warp {2}{W}', 'https://cards.scryfall.io/large/front/4/f/4fb36405-cd28-432f-b0a4-e74ff8be928d.jpg?1752946568', 5, 4, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Auxiliary Boosters', 5, 'common', 'Artifact — Equipment', 'When this Equipment enters, create a 2/2 colorless Robot artifact creature token and attach this Equipment to it.
Equipped creature gets +1/+2 and has flying.
Equip {3} ({3}: Attach to target creature you control. Equip only as a sorcery.)', 'https://cards.scryfall.io/large/front/4/3/43706295-afd6-442c-8828-8cf978152701.jpg?1752946573', NULL, NULL, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Banishing Light', 3, 'common', 'Enchantment', 'When this enchantment enters, exile target nonland permanent an opponent controls until this enchantment leaves the battlefield.', 'https://cards.scryfall.io/large/front/c/4/c45f11cd-a0aa-4d14-aa21-57f0969f3e2b.jpg?1752946576', NULL, NULL, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Beyond the Quiet', 5, 'rare', 'Sorcery', 'Exile all creatures and Spacecraft.', 'https://cards.scryfall.io/large/front/c/e/ce503869-8130-4afe-9691-4e90376b4bc4.jpg?1752946582', NULL, NULL, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Brightspear Zealot', 3, 'common', 'Creature — Human Soldier', 'Vigilance
This creature gets +2/+0 as long as you`ve cast two or more spells this turn.', 'https://cards.scryfall.io/large/front/e/7/e7f7541a-5910-4f33-8c1d-3507ce3a426e.jpg?1752946584', 2, 4, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Cosmogrand Zenith', 3, 'mythic', 'Creature — Human Soldier', 'Whenever you cast your second spell each turn, choose one —
• Create two 1/1 white Human Soldier creature tokens.
• Put a +1/+1 counter on each creature you control.', 'https://cards.scryfall.io/large/front/b/3/b3c1e5e3-4e6b-456a-958c-7a75c38f8183.jpg?1752946590', 2, 4, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Dawnstrike Vanguard', 6, 'uncommon', 'Creature — Human Knight', 'Lifelink
At the beginning of your end step, if you control two or more tapped creatures, put a +1/+1 counter on each creature you control other than this creature.', 'https://cards.scryfall.io/large/front/5/a/5a041722-9483-469f-9c17-7f0253b0db50.jpg?1752946591', 4, 5, NULL, NULL, 1);
-- SPM
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Anti-Venom, Horrifying Healer', 5, 'mythic', 'Legendary Creature — Symbiote Hero', 'When Anti-Venom enters, if he was cast, return target creature card from your graveyard to the battlefield.
If damage would be dealt to Anti-Venom, prevent that damage and put that many +1/+1 counters on him.', 'https://cards.scryfall.io/large/front/5/6/560384fe-7be0-4b93-a515-2fe687ab2492.jpg?1757376739', 5, 5, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Arachne, Psionic Weaver', 3, 'rare', 'Legendary Creature — Spider Human Hero', 'Web-slinging {W} (You may cast this spell for {W} if you also return a tapped creature you control to its owner`s hand.)
As Arachne enters, look at an opponent`s hand, then choose a card type other than creature.
Spells of the chosen type cost {1} more to cast.', 'https://cards.scryfall.io/large/front/7/c/7c1f871a-bd85-402e-b474-1deb64c18a52.jpg?1758285227', 3, 3, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Aunt May', 1, 'uncommon', 'Legendary Creature — Human Citizen', 'Whenever another creature you control enters, you gain 1 life. If it`s a Spider, put a +1/+1 counter on it.', 'https://cards.scryfall.io/large/front/a/d/ad96343b-baac-428c-8270-fcffbbbe9fb8.jpg?1757376751', 0, 2, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('City Pigeon', 1, 'common', 'Creature — Bird', 'Flying
When this creature leaves the battlefield, create a Food token. (It`s an artifact with "{2}, {T}, Sacrifice this token: You gain 3 life.")', 'https://cards.scryfall.io/large/front/5/6/56d67fb4-5b23-432c-9ffb-39545035c117.jpg?1758749844', 1, 1, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Costume Closet', 2, 'uncommon', 'Artifact', 'This artifact enters with two +1/+1 counters on it.
{T}: Move a +1/+1 counter from this artifact onto target creature you control. Activate only as a sorcery.
Whenever a modified creature you control leaves the battlefield, put a +1/+1 counter on this artifact. (Equipment, Auras you control, and counters are modifications.)', 'https://cards.scryfall.io/large/front/c/c/cc641f4a-ddbe-4f7d-bb55-eabf11f8b7fb.jpg?1757376764', NULL, NULL, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Daily Bugle Reporters', 4, 'common', 'Creature — Human Citizen', 'When this creature enters, choose one —
• Puff Piece — Put a +1/+1 counter on each of up to two target creatures.
• Investigative Journalism — Return target creature card with mana value 2 or less from your graveyard to your hand.', 'https://cards.scryfall.io/large/front/5/3/530dbeb0-b0cd-473e-a43e-7b23c88650a3.jpg?1757376770', 2, 3, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Flash Thompson, Spider-Fan', 2, 'uncommon', 'Legendary Creature — Human Citizen', 'Flash
When Flash Thompson enters, choose one or both —
• Heckle — Tap target creature.
• Hero Worship — Untap target creature.', 'https://cards.scryfall.io/large/front/4/4/44cf372b-f668-45e9-981e-4533295dcc74.jpg?1758203972', 2, 2, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Friendly Neighborhood', 4, 'rare', 'Enchantment — Aura', 'Enchant land
When this Aura enters, create three 1/1 green and white Human Citizen creature tokens.
Enchanted land has "{1}, {T}: Target creature gets +1/+1 until end of turn for each creature you control. Activate only as a sorcery."', 'https://cards.scryfall.io/large/front/1/7/17a18e2f-221f-4fc2-8dab-25bf12fb8756.jpg?1757376782', NULL, NULL, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Origin of Spider-Man', 2, 'rare', 'Enchantment — Saga', '(As this Saga enters and after your draw step, add a lore counter. Sacrifice after III.)
I — Create a 2/1 green Spider creature token with reach.
II — Put a +1/+1 counter on target creature you control. It becomes a legendary Spider Hero in addition to its other types.
III — Target creature you control gains double strike until end of turn.', 'https://cards.scryfall.io/large/front/a/1/a10a7da7-d9cb-495a-9c9f-205d355c390d.jpg?1757376788', NULL, NULL, NULL, NULL, 1);
INSERT INTO CARTI (NUME_CARTE, COST_MANA, RARITATE, LINIE_TIP, DESCRIERE, URL_IMAGINE, PUTERE, DURITATE, LOIALITATE, APARARE, NUMAR_DETINUT) VALUES ('Peter Parker', 2, 'mythic', 'Legendary Creature — Human Scientist Hero', 'When Peter Parker enters, create a 2/1 green Spider creature token with reach.
{1}{G}{W}{U}: Transform Peter Parker. Activate only as a sorcery.', 'https://cards.scryfall.io/large/front/3/c/3ce33422-5dba-4a42-8375-dd8ccc692a7b.jpg?1757433079', 0, 1, NULL, NULL, 1);

-- 3. PACHETE
INSERT INTO PACHETE (NUME_PACHET, FORMAT_JOC) 
VALUES ('TDM Pachet', 'sealed');
INSERT INTO PACHETE (NUME_PACHET, FORMAT_JOC) 
VALUES ('EOE Pachet', 'sealed');
INSERT INTO PACHETE (NUME_PACHET, FORMAT_JOC) 
VALUES ('SPM Pachet', 'sealed');
INSERT INTO PACHETE (NUME_PACHET, FORMAT_JOC) 
VALUES ('Standard Esper Midrange', 'standard');
INSERT INTO PACHETE (NUME_PACHET, FORMAT_JOC) 
VALUES ('Modern Boros Burn', 'modern');
INSERT INTO PACHETE (NUME_PACHET, FORMAT_JOC) 
VALUES ('Commander: Atraxa Superfriends', 'commander');
INSERT INTO PACHETE (NUME_PACHET, FORMAT_JOC) 
VALUES ('Legacy Reanimator', 'legacy');
INSERT INTO PACHETE (NUME_PACHET, FORMAT_JOC) 
VALUES ('Draft Simic Flyers', 'draft');
INSERT INTO PACHETE (NUME_PACHET, FORMAT_JOC) 
VALUES ('Draft Rakdos Aggro', 'draft');
INSERT INTO PACHETE (NUME_PACHET, FORMAT_JOC) 
VALUES ('Modern Tron', 'modern');
INSERT INTO PACHETE (NUME_PACHET, FORMAT_JOC) 
VALUES ('Commander: Lathril Elves', 'commander');

-- 4. LOCATII 
INSERT INTO LOCATII (NUME_LOCATIE, TARA, ORAS, STRADA, NUMAR, PARTENER_WOTC) 
VALUES ('Krit Ploiesti', 'Romania', 'Ploiesti', 'Buna Vestire', '55', 'core');
INSERT INTO LOCATII (NUME_LOCATIE, TARA, ORAS, STRADA, NUMAR, PARTENER_WOTC) 
VALUES ('Krit Brasov', 'Romania', 'Brasov', 'Lunga', '51', 'advanced');
INSERT INTO LOCATII (NUME_LOCATIE, TARA, ORAS, STRADA, NUMAR, PARTENER_WOTC) 
VALUES ('Red Goblin', 'Romania', 'Bucuresti', 'Stirbei Voda', '4', 'core');
INSERT INTO LOCATII (NUME_LOCATIE, TARA, ORAS, STRADA, NUMAR, PARTENER_WOTC) 
VALUES ('The Guild Hall', 'Romania', 'Cluj-Napoca', 'Strada Samuil Micu', '4', 'advanced');
INSERT INTO LOCATII (NUME_LOCATIE, TARA, ORAS, STRADA, NUMAR, PARTENER_WOTC) 
VALUES ('Lex Hobby Store', 'Romania', 'Iasi', 'Soseaua Pacurari', '158', 'advanced');
INSERT INTO LOCATII (NUME_LOCATIE, TARA, ORAS, STRADA, NUMAR, PARTENER_WOTC) 
VALUES ('Gamesline', 'Romania', 'Timisoara', 'Bulevardul 16 Decembrie', '12', 'advanced');
INSERT INTO LOCATII (NUME_LOCATIE, TARA, ORAS, STRADA, NUMAR, PARTENER_WOTC) 
VALUES ('GeekHub', 'Romania', 'Sibiu', 'Strada Turnului', '12', 'core');
INSERT INTO LOCATII (NUME_LOCATIE, TARA, ORAS, STRADA, NUMAR, PARTENER_WOTC) 
VALUES ('Star City Games', 'USA', 'Roanoke', 'Williamson Rd', '5728', 'core');
INSERT INTO LOCATII (NUME_LOCATIE, TARA, ORAS, STRADA, NUMAR, PARTENER_WOTC) 
VALUES ('Mox Boarding House', 'USA', 'Seattle', 'Leary Ave NW', '5105', 'advanced');
INSERT INTO LOCATII (NUME_LOCATIE, TARA, ORAS, STRADA, NUMAR, PARTENER_WOTC) 
VALUES ('CoolStuffGames', 'USA', 'Maitland', 'South Orlando Dr', '8550', 'advanced');

-- 5. JUCATORI
INSERT INTO JUCATORI (NUME, PRENUME, GAMEID, EMAIL) 
VALUES ('Popescu', 'Andrei', 'AndreiP_Main', 'andrei.popescu@email.com');
INSERT INTO JUCATORI (NUME, PRENUME, GAMEID, EMAIL) 
VALUES ('Ionescu', 'Radu', 'RaduI_Mage', 'radu.ionescu@email.com');
INSERT INTO JUCATORI (NUME, PRENUME, GAMEID, EMAIL) 
VALUES ('Dumitru', 'Elena', 'Ely_Magic', 'elena.dumitru@email.com');
INSERT INTO JUCATORI (NUME, PRENUME, GAMEID, EMAIL) 
VALUES ('Stoica', 'Victor', 'VicS_Slayer', 'victor.stoica@email.com');
INSERT INTO JUCATORI (NUME, PRENUME, GAMEID, EMAIL) 
VALUES ('Gheorghe', 'Maria', 'MariaG_Star', 'maria.gheorghe@email.com');
INSERT INTO JUCATORI (NUME, PRENUME, GAMEID, EMAIL) 
VALUES ('Stan', 'Cristian', 'Cristi_MTG', 'cristian.stan@email.com');
INSERT INTO JUCATORI (NUME, PRENUME, GAMEID, EMAIL) 
VALUES ('Matei', 'Andreea', 'DreeaM_22', 'andreea.matei@email.com');
INSERT INTO JUCATORI (NUME, PRENUME, GAMEID, EMAIL) 
VALUES ('Constantin', 'Florin', 'FlorinC_Pro', 'florin.constantin@email.com');
INSERT INTO JUCATORI (NUME, PRENUME, GAMEID, EMAIL) 
VALUES ('Dobre', 'Ioana', 'Ioana_Wiz', 'ioana.dobre@email.com');
INSERT INTO JUCATORI (NUME, PRENUME, GAMEID, EMAIL) 
VALUES ('Rusu', 'Mihai', 'MikeR_Rogue', 'mihai.rusu@email.com');
INSERT INTO JUCATORI (NUME, PRENUME, GAMEID, EMAIL) 
VALUES ('Marin', 'Simona', 'Simo_Elf', 'simona.marin@email.com');
INSERT INTO JUCATORI (NUME, PRENUME, GAMEID, EMAIL) 
VALUES ('Vasile', 'Silviu', 'Vasile_Gamer', 'vsl@email.com');

-- 6. EVENIMENTE
INSERT INTO EVENIMENTE (NUME_EVENIMENT, DATA_EVENIMENT, TIP, ID_LOCATIE, COD_SET) 
VALUES ('Prerelease Tarkir: Dragonstorm', DATE '2025-04-11', 'tournament', 1, 'TDM');
INSERT INTO EVENIMENTE (NUME_EVENIMENT, DATA_EVENIMENT, TIP, ID_LOCATIE, COD_SET) 
VALUES ('Prerelease Edge of Eternities', DATE '2025-08-01', 'tournament', 2, 'EOE');
INSERT INTO EVENIMENTE (NUME_EVENIMENT, DATA_EVENIMENT, TIP, ID_LOCATIE, COD_SET) 
VALUES ('Prerelease Marvels Spider-Man ', DATE '2025-09-26', 'tournament', 3, 'SPM');
INSERT INTO EVENIMENTE (NUME_EVENIMENT, DATA_EVENIMENT, TIP, ID_LOCATIE, COD_SET) 
VALUES ('Friday Night Standard Showdown', DATE '2025-10-03', 'tournament', 4, 'BLB');
INSERT INTO EVENIMENTE (NUME_EVENIMENT, DATA_EVENIMENT, TIP, ID_LOCATIE, COD_SET) 
VALUES ('Modern RCQ Qualifier', DATE '2025-10-10', 'tournament', 5, 'MH3');
INSERT INTO EVENIMENTE (NUME_EVENIMENT, DATA_EVENIMENT, TIP, ID_LOCATIE, COD_SET) 
VALUES ('Commander Party: Universes Beyond', DATE '2025-10-12', 'casual', 6, 'OTJ');
INSERT INTO EVENIMENTE (NUME_EVENIMENT, DATA_EVENIMENT, TIP, ID_LOCATIE, COD_SET) 
VALUES ('Legacy Dual Land Championship', DATE '2025-10-18', 'tournament', 7, 'RVR');
INSERT INTO EVENIMENTE (NUME_EVENIMENT, DATA_EVENIMENT, TIP, ID_LOCATIE, COD_SET) 
VALUES ('Chaos Draft Weekend', DATE '2025-10-24', 'limited', 8, 'LCI');
INSERT INTO EVENIMENTE (NUME_EVENIMENT, DATA_EVENIMENT, TIP, ID_LOCATIE, COD_SET) 
VALUES ('Standard Store Championship', DATE '2025-11-01', 'tournament', 9, 'WOE');
INSERT INTO EVENIMENTE (NUME_EVENIMENT, DATA_EVENIMENT, TIP, ID_LOCATIE, COD_SET) 
VALUES ('Commander Open Play Night', DATE '2025-11-07', 'casual', 10, 'LTR');

-- 7. MECIURI
-- Eveniment 1 (TDM)
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE,  RUNDA ) VALUES (1, 2, 0, 1);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE,  RUNDA ) VALUES (1, 1, 2, 2);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE,  RUNDA ) VALUES (1, 1, 2, 3);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE,  RUNDA ) VALUES (1, 2, 0, 4);
-- Eveniment 2 (EOE)
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE,  RUNDA ) VALUES (2, 2, 1, 1);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE,  RUNDA ) VALUES (2, 2, 0, 2);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE,  RUNDA ) VALUES (2, 2, 0, 3);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE,  RUNDA ) VALUES (2, 2, 1, 4);
-- Eveniment 3 (SPM)
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE,  RUNDA ) VALUES (3, 2, 0, 1);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE,  RUNDA ) VALUES (3, 1, 2, 2);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE,  RUNDA ) VALUES (3, 1, 2, 3);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE,  RUNDA ) VALUES (3, 0, 2, 4);
-- Eveniment 4 (Standard Showdown - Cluj)
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE, RUNDA) VALUES (4, 2, 1, 1);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE, RUNDA) VALUES (4, 0, 2, 1);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE, RUNDA) VALUES (4, 2, 0, 2);
-- Eveniment 5 (Modern RCQ - Iasi)
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE, RUNDA) VALUES (5, 2, 0, 1);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE, RUNDA) VALUES (5, 1, 2, 2);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE, RUNDA) VALUES (5, 2, 1, 3);
-- Eveniment 8 (Chaos Draft - USA)
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE, RUNDA) VALUES (8, 2, 1, 1);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE, RUNDA) VALUES (8, 2, 0, 2);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE, RUNDA) VALUES (8, 0, 2, 3);
-- Eveniment 9 (Store Championship - USA)
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE, RUNDA) VALUES (9, 2, 1, 1);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE, RUNDA) VALUES (9, 2, 1, 2);
INSERT INTO MECIURI (ID_EVENIMENT, JOCURI_CASTIGATE, JOCURI_PIERDUTE, RUNDA) VALUES (9, 1, 2, 3);

-- 8. CARTI_SETURI
-- TDM
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('TDM', 'Ugin, Eye of the Storms', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('TDM', 'Anafenza, Unyielding Lineage', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('TDM', 'Arashin Sunshield', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('TDM', 'Bearer of Glory', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('TDM', 'Clarion Conqueror', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('TDM', 'Coordinated Maneuver', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('TDM', 'Dalkovan Packbeasts', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('TDM', 'Descendant of Storms', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('TDM', 'Dragonback Lancer', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('TDM', 'Duty Beyond Death', 2);
-- EOE
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('EOE', 'Anticausal Vestige', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('EOE', 'Tezzeret, Cruel Captain', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('EOE', 'All-Fates Stalker', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('EOE', 'Astelli Reclaimer', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('EOE', 'Auxiliary Boosters', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('EOE', 'Banishing Light', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('EOE', 'Beyond the Quiet', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('EOE', 'Brightspear Zealot', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('EOE', 'Cosmogrand Zenith', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('EOE', 'Dawnstrike Vanguard', 2);
-- SPM 
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('SPM', 'Anti-Venom, Horrifying Healer', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('SPM', 'Arachne, Psionic Weaver', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('SPM', 'Aunt May', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('SPM', 'City Pigeon', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('SPM', 'Costume Closet', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('SPM', 'Daily Bugle Reporters', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('SPM', 'Flash Thompson, Spider-Fan', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('SPM', 'Friendly Neighborhood', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('SPM', 'Origin of Spider-Man', 2);
INSERT INTO CARTI_SETURI (COD_SET, NUME_CARTE, NUMAR_COPII) VALUES ('SPM', 'Peter Parker', 2);

-- 9. PACHETE_CARTI
-- PACHET 1 (TDM Sealed)
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (1, 'Ugin, Eye of the Storms', 1, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (1, 'Anafenza, Unyielding Lineage', 1, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (1, 'Arashin Sunshield', 2, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (1, 'Bearer of Glory', 2, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (1, 'Clarion Conqueror', 1, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (1, 'Coordinated Maneuver', 3, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (1, 'Dalkovan Packbeasts', 2, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (1, 'Descendant of Storms', 2, 'main');
-- PACHET 2 (EOE Sealed)
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (2, 'Tezzeret, Cruel Captain', 1, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (2, 'Anticausal Vestige', 1, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (2, 'Auxiliary Boosters', 3, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (2, 'Banishing Light', 2, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (2, 'Brightspear Zealot', 3, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (2, 'Cosmogrand Zenith', 1, 'main');
-- PACHET 3 (SPM Sealed)
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (3, 'Peter Parker', 1, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (3, 'Anti-Venom, Horrifying Healer', 1, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (3, 'Arachne, Psionic Weaver', 1, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (3, 'City Pigeon', 4, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (3, 'Daily Bugle Reporters', 3, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (3, 'Friendly Neighborhood', 2, 'main');
-- PACHET 4 (Standard Esper Midrange)
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (4, 'Banishing Light', 4, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (4, 'Tezzeret, Cruel Captain', 2, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (4, 'Cosmogrand Zenith', 2, 'side');
-- PACHET 5 (Modern Boros Burn)
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (5, 'Coordinated Maneuver', 4, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (5, 'Dragonback Lancer', 4, 'main');
-- PACHET 6 (Commander: Atraxa Superfriends)
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (6, 'Tezzeret, Cruel Captain', 1, 'side');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (6, 'Costume Closet', 1, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (6, 'Dawnstrike Vanguard', 1, 'main');
-- PACHET 7 (Legacy Reanimator)
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (7, 'Anticausal Vestige', 4, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (7, 'Anti-Venom, Horrifying Healer', 3, 'main');
-- PACHET 8 (Draft Simic Flyers)
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (8, 'City Pigeon', 3, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (8, 'Clarion Conqueror', 1, 'main');
-- PACHET 9 (Draft Rakdos Aggro)
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (9, 'Dalkovan Packbeasts', 2, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (9, 'Auxiliary Boosters', 1, 'main');
-- PACHET 10 (Modern Tron)
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (10, 'Ugin, Eye of the Storms', 4, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (10, 'Beyond the Quiet', 2, 'side');
-- PACHET 11 (Commander: Lathril Elves)
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (11, 'Friendly Neighborhood', 1, 'main');
INSERT INTO PACHETE_CARTI (ID_PACHET, NUME_CARTE, CANTITATE, ZONA_PACHET) VALUES (11, 'Anafenza, Unyielding Lineage', 1, 'main');

-- 10. MECIURI_JUCATORI
-- Meciuri TDM (1-4) vs Jucători 1-4
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (1, 1, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (2, 2, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (3, 3, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (4, 4, 'enemy');
-- Meciuri EOE (5-8) vs Jucători 5-8
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (5, 5, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (6, 6, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (7, 7, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (8, 8, 'enemy');
-- Meciuri SPM (9-12) vs Jucători 9-12
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (9, 9, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (10, 10, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (11, 11, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (12, 12, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (13, 1, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (14, 1, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (15, 1, 'enemy');
--
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (16, 2, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (17, 2, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (18, 2, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (19, 3, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (20, 3, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (21, 3, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (22, 4, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (23, 4, 'enemy');
INSERT INTO MECIURI_JUCATORI (ID_MECI, ID_JUCATOR, ROL_JUCATOR) VALUES (24, 4, 'enemy');

-- 11. PACHETE_MECIURI
-- Meciuri TDM folosesc Pachetul 1
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (1, 1, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (1, 2, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (1, 3, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (1, 4, 'friend');
-- Meciuri EOE folosesc Pachetul 2
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (2, 5, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (2, 6, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (2, 7, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (2, 8, 'friend');
-- Meciuri SPM folosesc Pachetul 3
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (3, 9, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (3, 10, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (3, 11, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (3, 12, 'friend');
--
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (4, 13, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (4, 14, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (4, 15, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (5, 16, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (5, 17, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (5, 18, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (8, 19, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (8, 20, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (8, 21, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (10, 22, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (10, 23, 'friend');
INSERT INTO PACHETE_MECIURI (ID_PACHET, ID_MECI, UTILIZAT_DE) VALUES (10, 24, 'friend');
COMMIT;