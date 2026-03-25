-- 1-)
SELECT 
    i.ID, 
    i.name, 
    COUNT(t.ID) AS [Number of sections]
FROM 
    instructor i LEFT OUTER JOIN teaches t ON i.ID = t.ID
GROUP BY 
    i.ID, 
    i.name
ORDER BY i.ID;

-- 2-)
SELECT 
    i.ID, 
    i.name, 
    (SELECT COUNT(*) FROM teaches t WHERE t.ID = i.ID) AS [Number of sections]
FROM instructor i
ORDER BY i.ID;

-- 3-)
SELECT 
    s.course_id, 
    s.sec_id, 
    t.ID, 
    s.semester, 
    s.year, 
    COALESCE(i.name, '-') AS name
FROM 
    section s LEFT JOIN teaches t ON s.course_id = t.course_id AND s.sec_id = t.sec_id AND s.semester = t.semester AND s.year = t.year
        LEFT JOIN instructor i ON t.ID = i.ID WHERE s.semester = 'Spring' AND s.year = 2010
ORDER BY 
    s.course_id, 
    s.sec_id;

-- 4-)
SELECT 
    s.ID, 
    s.name, 
    c.title, 
    c.dept_name, 
    t.grade, 
CASE t.grade -- Função encontrada similar ao case switch
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
END AS points, c.credits, 
(c.credits * CASE t.grade
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
                END) AS [Pontos totais]
FROM 
    dbo.student s JOIN dbo.takes t ON s.ID = t.ID JOIN dbo.course c ON t.course_id = c.course_id WHERE t.grade IS NOT NULL
ORDER BY s.ID; -- Não consegui replicar a ordem, então deixei por ID

-- 5-)
GO
CREATE VIEW coeficiente_rendimento AS
    SELECT 
        s.ID, 
        s.name, 
        c.title, 
        c.dept_name, 
        t.grade, 
    CASE t.grade -- Função encontrada similar ao case switch
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
    END AS points, c.credits, 
    (c.credits * CASE t.grade
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
                    END) AS [Pontos totais]
    FROM 
        dbo.student s JOIN dbo.takes t ON s.ID = t.ID JOIN dbo.course c ON t.course_id = c.course_id WHERE t.grade IS NOT NULL