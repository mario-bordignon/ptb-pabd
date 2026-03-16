-- ATV 1:
SELECT * FROM student FULL OUTER JOIN takes ON student.id = takes.id;

-- ATV 2:
SELECT 
    std.ID, 
    std.name, 
    COUNT(t.course_id) AS quantidade_cursos
FROM 
    student std
INNER JOIN 
    takes t ON std.ID = t.ID
WHERE std.dept_name = 'Civil Eng.'
GROUP BY 
    std.ID, 
    std.name
ORDER BY quantidade_cursos DESC;

-- ATV 3:
GO -- Comando que encontrei para corrigir a reclamação de batch do VSCODE
CREATE VIEW civil_eng_students as
    SELECT 
        std.ID, 
        std.name, 
        COUNT(t.course_id) AS quantidade_cursos
    FROM 
        student std
    JOIN 
        takes t ON std.ID = t.ID
    WHERE 
        std.dept_name = 'Civil Eng.'
    GROUP BY 
        std.ID, 
        std.name;
GO 

SELECT * FROM civil_eng_students
ORDER BY quantidade_cursos DESC;