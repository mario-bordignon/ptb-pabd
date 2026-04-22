-- 1-)

GRANT SELECT ON dbo.instructor (ID, name, dept_name) TO User_B;
GRANT SELECT ON dbo.takes (ID, course_id, sec_id, semester, year) TO User_B;

-- 2-)

GRANT SELECT, UPDATE ON dbo.section (course_id, sec_id, semester, year) TO User_C;

-- 3-)

GRANT SELECT ON dbo.instructor TO User_D;
GRANT SELECT ON dbo.student TO User_D;
GRANT SELECT ON dbo.grade_points TO User_D;

-- 4-)
GO
CREATE VIEW dbo.view_student_civil_eng AS
SELECT * FROM dbo.student 
WHERE dept_name = 'Civil Eng.';
GO

GRANT SELECT ON dbo.view_student_civil_eng TO User_E;

-- 5-)

REVOKE SELECT ON dbo.view_student_civil_eng TO User_E;

-- 6-)

SELECT 
    dp.name AS Usuario,
    obj.name AS Objeto,
    perm.permission_name,
    perm.state_desc
FROM sys.database_permissions perm
JOIN sys.database_principals dp 
    ON perm.grantee_principal_id = dp.principal_id
JOIN sys.objects obj 
    ON perm.major_id = obj.object_id
WHERE dp.name IN ('User_A', 'User_B', 'User_C', 'User_D', 'User_E');