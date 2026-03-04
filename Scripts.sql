-- 1. Tabela de Alimentos --
CREATE TABLE Alimentos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    cal_100g INTEGER NOT NULL,
    prot_100g INTEGER,
    lip_100g INTEGER
);

-- 2. Tabela de Refeições --
CREATE TABLE Refeicoes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data DATE NOT NULL,
    cal_100g INTEGER NOT NULL,
    prot_100g INTEGER,
    lip_100g INTEGER
);

-- 3. Tabela de ligação entre alimentos e refeições --
CREATE TABLE Alimentos_Refeicoes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_refeicao INTEGER,
    id_alimento INTEGER,
    quantidade DOUBLE(2, 2),
    FOREIGN KEY (id_refeicao) REFERENCES Refeicoes(id) ON DELETE CASCADE,
    FOREIGN KEY (id_alimento) REFERENCES Alimentos(id)
);

-- insert dos alimentos --
INSERT INTO Alimentos (nome, cal_100g, prot_100g, lip_100g)
VALUES ('Peito de Frango Grelhado', 165, 31, 4),
    ('Carne de Vaca Picada (Patinho)', 220, 26, 12),
    ('Lombo de Porco Assado', 210, 28, 10),
    ('Salmão Grelhado', 208, 22, 13),
    ('Atum em Lata (em Água)', 116, 26, 1),
    ('Ovo Cozido (Grande - unid)', 155, 13, 11),
    ('Fiambre de Peru (Fatias)', 100, 18, 2),
    ('Arroz Branco Cozido', 130, 3, 0),
    ('Massa (Esparguete) Cozida', 158, 6, 1),
    ('Batata Doce Assada', 103, 2, 0),
    ('Batata Inglesa Cozida', 87, 2, 0),
    ('Quinoa Cozida', 120, 4, 2),
    ('Aveia em Flocos (Crua)', 389, 17, 7),
    ('Pão Integral (Fatia)', 247, 13, 3),
    ('Tapioca (Goma Pronta)', 240, 0, 0),
    ('Brócolos Cozidos', 35, 2, 0),
    ('Espinafres Cozidos', 23, 3, 0),
    ('Alface (Crua)', 15, 1, 0),
    ('Tomate (Cru)', 18, 1, 0),
    ('Cenoura Cozida', 41, 1, 0),
    ('Feijão Preto Cozido', 132, 9, 1),
    ('Grão de Bico Cozido', 164, 9, 3),
    ('Cogumelos Champignon Cozidos', 22, 3, 0),
    ('Maçã (com casca)', 52, 0, 0),
    ('Banana Prata', 89, 1, 0),
    ('Laranja (Média)', 47, 1, 0),
    ('Morangos', 32, 1, 0),
    ('Uvas Pretas', 69, 1, 0),
    ('Abacate', 160, 2, 15),
    ('Kiwi', 61, 1, 1),
    ('Azeite de Oliva Extra Virgem', 884, 0, 100),
    ('Manteiga de Amendoim (Natural)', 588, 25, 50),
    ('Amêndoas (Cruas)', 579, 21, 50),
    ('Nozes', 654, 15, 65),
    ('Leite Meio-Gordo', 42, 3, 2),
    ('Iogurte Grego Natural', 59, 10, 0),
    ('Queijo Cottage', 98, 11, 4),
    ('Queijo Mozzarella', 280, 22, 22),
    ('Granola (Média)', 471, 10, 20),
    ('Chocolate Negro (70%+)', 600, 8, 43);

-- insert das refeicoes feitas --
INSERT INTO Refeicoes (id, data, cal_100g, prot_100g, lip_100g)
VALUES (1, '2026-11-01', 422, 16, 11),
    (2, '2026-11-01', 428, 44, 5),
    (3, '2026-11-01', 526, 38, 20),
    (4, '2026-11-02', 110, 11, 0),
    (5, '2026-11-02', 432, 23, 17),
    (6, '2026-11-02', 641, 46, 26),
    (7, '2026-11-02', 456, 35, 21),
    (8, '2026-11-03', 385, 17, 12),
    (9, '2026-11-03', 602, 49, 17),
    (10, '2026-11-03', 410, 10, 33);

-- insert dos alimentos das refeições --
INSERT INTO Alimentos_Refeicoes (id_refeicao, id_alimento, quantidade)
VALUES (1, 13, 0.60),
    (1, 25, 1.00),
    (1, 35, 2.50),
    (2, 8, 1.50),
    (2, 1, 1.20),
    (2, 16, 1.00),
    (3, 4, 1.50),
    (3, 10, 2.00),
    (3, 18, 1.00),
    (4, 36, 1.50),
    (4, 27, 0.70),
    (5, 14, 1.00),
    (5, 6, 1.20),
    (5, 31, 0.10),
    (6, 2, 1.50),
    (6, 9, 1.80),
    (6, 19, 1.50),
    (7, 5, 1.00),
    (7, 22, 1.50),
    (7, 31, 0.15),
    (8, 36, 2.00),
    (8, 39, 0.50),
    (8, 30, 0.50),
    (9, 3, 1.50),
    (9, 8, 1.20),
    (9, 21, 1.00),
    (10, 40, 0.40),
    (10, 33, 0.30);

-- obter alimentos --
SELECT *
from Alimentos 

-- obter refeições --
SELECT *
from Refeicoes

-- obter alimentos a partir do id da refeição --
SELECT A.nome,
    A.cal_100g,
    AR.quantidade,
    (A.cal_100g * AR.quantidade) AS calorias_totais
FROM Alimentos_Refeicoes AR
    JOIN Alimentos A ON AR.id_alimento = A.id
WHERE AR.id_refeicao = 1;

--alimento mais consumido--
SELECT A.nome,
    COUNT(AR.id_alimento) AS Vezes_Consumido
FROM Alimentos_Refeicoes AR
    JOIN Alimentos A ON AR.id_alimento = A.id
GROUP BY A.nome
ORDER BY Vezes_Consumido DESC
LIMIT 5;

-- obter refeições feitas em 1 dia especifico --
SELECT id,
    data,
    cal_100g,
    prot_100g,
    lip_100g
FROM Refeicoes
WHERE data = '2026-11-01';

--obter alimentos consumidos em 1 dia especifico --
SELECT R.id AS Refeicao_ID,
    A.nome AS Alimento,
    AR.quantidade AS Qnt,
    (A.cal_100g * AR.quantidade) AS Kcal_Item
FROM Refeicoes R
    JOIN Alimentos_Refeicoes AR ON R.id = AR.id_refeicao
    JOIN Alimentos A ON AR.id_alimento = A.id
WHERE R.data = '2026-11-01'
ORDER BY R.id;