-- 1-) 
GO
CREATE PROCEDURE dbo.student_grade_points
    @conceito VARCHAR(2)
AS
BEGIN
    SELECT 
        s.name AS [Nome do estudante], 
        s.dept_name AS [Departamento do estudante], 
        c.title AS [Título do curso], 
        c.dept_name AS [Departamento do curso], 
        t.semester AS [Semestre do curso], 
        t.year AS [Ano do curso], 
        t.grade AS [Pontuação alfanumérica],
        CASE t.grade 
            WHEN 'A+' THEN 4.0
            WHEN 'A'  THEN 3.7
            WHEN 'A-' THEN 3.3
            WHEN 'B+' THEN 3.0
            WHEN 'B'  THEN 2.7
            WHEN 'B-' THEN 2.3
            WHEN 'C+' THEN 2.0
            WHEN 'C'  THEN 1.7
            WHEN 'C-' THEN 1.3
            ELSE 0 
        END AS [Pontuação numérica]
    FROM 
        dbo.student s
    INNER JOIN 
        dbo.takes t ON s.ID = t.ID
    INNER JOIN 
        dbo.course c ON t.course_id = c.course_id
    WHERE 
        t.grade = @conceito;
END;
GO

-- 2-)
GO
CREATE FUNCTION dbo.return_instructor_location (@nome_instrutor VARCHAR(255))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        i.name AS [Nome do instrutor],
        c.title AS [Curso ministrado],
        s.semester AS [Semestre do curso],
        s.year AS [Ano do curso],
        s.building AS [Prédio],
        s.room_number AS [Número da sala]
    FROM 
        dbo.instructor i
    INNER JOIN 
        dbo.teaches t ON i.ID = t.ID
    INNER JOIN 
        dbo.section s ON t.course_id = s.course_id 
                      AND t.sec_id = s.sec_id 
                      AND t.semester = s.semester 
                      AND t.year = s.year
    INNER JOIN 
        dbo.course c ON t.course_id = c.course_id
    WHERE 
        i.name = @nome_instrutor
);
GO