-- 1-)
CREATE TRIGGER dbo.lost_credits
ON dbo.takes 
AFTER DELETE
AS
BEGIN
    UPDATE s
    SET s.tot_cred = s.tot_cred - c.credits
    FROM dbo.student s
    INNER JOIN deleted d ON s.ID = d.ID
    INNER JOIN dbo.course c ON d.course_id = c.course_id;
END;

/* Testando
BEGIN TRAN;

-- Cursos de estudante aleatório
SELECT course_id
FROM dbo.takes
WHERE ID = '1018';

-- 1. Créditos atuais dele
SELECT ID, name, tot_cred 
FROM dbo.student 
WHERE ID = '1018';

-- 2. Valor do curso
SELECT course_id, title, credits 
FROM dbo.course 
WHERE course_id = '105';

-- 3. Ativando a trigger
DELETE FROM dbo.takes 
WHERE ID = '1018' AND course_id = '105';

-- Checando se funcionou
SELECT ID, name, tot_cred 
FROM dbo.student 
WHERE ID = '1018';

-- Antes era 81, depois 78, retirou os 3 créditos corretamente

ROLLBACK;
*/