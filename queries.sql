SELECT * FROM tasks
WHERE user_id = 1;


SELECT * FROM tasks
WHERE status_id = (
    SELECT id FROM status WHERE name = 'new'
);


SELECT * FROM tasks
WHERE status_id = (
    SELECT id FROM status WHERE name = 'new'
);


SELECT * FROM users
WHERE id NOT IN (
    SELECT DISTINCT user_id FROM tasks
);


SELECT * FROM tasks
WHERE status_id != (
    SELECT id FROM status WHERE name = 'completed'
);


SELECT * FROM users
WHERE email LIKE '%gmail%';

UPDATE users
SET fullname = 'Updated Name'
WHERE id = 1;


SELECT s.name, COUNT(t.id) AS task_count
FROM status s
LEFT JOIN tasks t ON s.id = t.status_id
GROUP BY s.name;


SELECT t.*
FROM tasks t
JOIN users u ON t.user_id = u.id
WHERE u.email LIKE '%@example.com';


SELECT * FROM tasks
WHERE description IS NULL;

SELECT u.fullname, t.title
FROM users u
INNER JOIN tasks t ON u.id = t.user_id
INNER JOIN status s ON t.status_id = s.id
WHERE s.name = 'in progress';


SELECT u.fullname, COUNT(t.id) AS task_count
FROM users u
LEFT JOIN tasks t ON u.id = t.user_id
GROUP BY u.id;
