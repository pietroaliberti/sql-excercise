CREATE SCHEMA toysg;
CREATE TABLE Product (
    ID_Prodotto INT PRIMARY KEY,
    Nome_Prodotto VARCHAR(50),
    Categoria VARCHAR(50)
);

CREATE TABLE Region (
    ID_Regione INT PRIMARY KEY,
    Nome_Regione VARCHAR(50),
    Stato VARCHAR(50)
);

CREATE TABLE Sales (
    ID_Transazione INT PRIMARY KEY,
    ID_Prodotto INT,
    ID_Regione INT,
    Data_Vendita DATE,
    Importo DECIMAL(10, 2),
    FOREIGN KEY (ID_Prodotto) REFERENCES Product(ID_Prodotto),
    FOREIGN KEY (ID_Regione) REFERENCES Region(ID_Regione)
);

INSERT INTO Product (ID_Prodotto, Nome_Prodotto, Categoria)
VALUES
    (1, 'Giocattolo A', 'Giocattoli per bambini'),
    (2, 'Giocattolo B', 'Peluche'),
    (3, 'Giocattolo C', 'Costruzioni');

INSERT INTO Region (ID_Regione, Nome_Regione, Stato)
VALUES
    (1, 'Europa Centrale', 'Italia'),
    (2, 'Nord America', 'Stati Uniti'),
    (3, 'Asia Orientale', 'Giappone');

INSERT INTO Sales (ID_Transazione, ID_Prodotto, ID_Regione, Data_Vendita, Importo)
VALUES
    (1, 1, 1, '2023-01-15', 25.99),
    (2, 2, 2, '2023-02-20', 15.50),
    (3, 1, 3, '2023-03-10', 30.00),
    (4, 3, 1, '2023-04-05', 18.75);
    
-- Es.1 Verifica unicità dei campi PK
    
SELECT COUNT(*) AS Numero_Record, COUNT(DISTINCT ID_Prodotto) AS Prodotti_Univoci
FROM Product;

SELECT COUNT(*) AS Numero_Record, COUNT(DISTINCT ID_Regione) AS Regioni_Univoche
FROM Region;

SELECT COUNT(*) AS Numero_Record, COUNT(DISTINCT ID_Transazione) AS Transazioni_Univoche
FROM Sales;

-- Es.2 Elenco dei prodotti venduti con fatturato totale per anno
SELECT p.Nome_Prodotto, YEAR(s.Data_Vendita) AS Anno, SUM(s.Importo) AS Fatturato_Totale
FROM Product p
JOIN Sales s ON p.ID_Prodotto = s.ID_Prodotto
GROUP BY p.Nome_Prodotto, YEAR(s.Data_Vendita);

-- Es.3 Fatturato totale per stato per anno
SELECT r.Stato, YEAR(s.Data_Vendita) AS Anno, SUM(s.Importo) AS Fatturato_Totale
FROM Region r
JOIN Sales s ON r.ID_Regione = s.ID_Regione
GROUP BY r.Stato, YEAR(s.Data_Vendita)
ORDER BY YEAR(s.Data_Vendita), SUM(s.Importo) DESC;

-- Es.4 categoria di articoli maggiormente richiesta
SELECT p.Categoria, COUNT(*) AS Numero_Vendite
From Product p
Join Sales s ON p.ID_Prodotto = s.ID_Prodotto
GROUP BY p.Categoria
ORDER BY Numero_Vendite DESC
LIMIT 1;

-- Es.5 Prodotti invenduti approccio 1
SELECT p.*
FROM Product p
LEFT JOIN Sales s ON p.ID_Prodotto = s.ID_Prodotto
WHERE s.ID_Transazione IS NULL;

-- approccio 2
SELECT *
FROM Product
WHERE ID_Prodotto NOT IN (SELECT DISTINCT ID_Prodotto FROM Sales);

-- Es.6 Elenco dei prodotti con la data di vendita più recente
SELECT p.Nome_Prodotto, MAX(s.Data_Vendita) AS Ultima_Data_Vendita
FROM Product p
JOIN Sales s ON p.ID_Prodotto = s.ID_Prodotto
GROUP BY p.Nome_Prodotto;






