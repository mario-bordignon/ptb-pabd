-- 1-)
CREATE TRIGGER dbo.trigger_prevent_assignment_teaches
ON dbo.teaches
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT t.ID, t.year
        FROM dbo.teaches t
        INNER JOIN inserted i ON t.ID = i.ID AND t.year = i.year
        GROUP BY t.ID, t.year
        HAVING COUNT(*) > 2
    )
    BEGIN
        RAISERROR ('Operação cancelada: O instrutor não pode ter mais de 2 atribuições no mesmo ano.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

/* TESTANDO
BEGIN TRAN;

INSERT INTO dbo.teaches (ID, course_id, sec_id, semester, year)
VALUES
('14365', '169', '1', 'Spring', 2007), 
('14365', '258', '1', 'Fall', 2007), 
('14365', '338', '1', 'Spring', 2007);

-- Disparou o erro

ROLLBACK TRAN; */