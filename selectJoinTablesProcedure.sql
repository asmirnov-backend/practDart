CREATE PROCEDURE SelectJoinTables(IN table1_name VARCHAR(255), IN table2_name VARCHAR(255))
BEGIN
    SELECT a.column1, b.column2
    FROM table1_name a
    JOIN table2_name b ON a.id = b.id;
END;