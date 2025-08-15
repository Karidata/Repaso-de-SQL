--- Cruce entre usuarios y post --- 

SELECT 
    u.nombre,
    u.email,
    p.titulo,
    p.contenido
FROM 
    usuarios u
LEFT JOIN 
    posts p ON u.id = p.usuario_id
WHERE 
    p.id IS NOT NULL;



--- Muestra el id, título y contenido de los posts de los administradores. ---

SELECT 
    p.id,
    p.titulo,
    p.contenido
FROM 
    posts p
JOIN 
    usuarios u ON p.usuario_id = u.id
WHERE 
    u.rol = 'administrador';


--- Cuenta la cantidad de posts de cada usuario. --- 

SELECT 
    u.id,
    u.email,
    COUNT(p.id) AS cantidad_posts
FROM 
    usuarios u
LEFT JOIN 
    posts p ON u.id = p.usuario_id
GROUP BY 
    u.id, u.email;


--- Muestra el email del usuario que ha creado más posts ---

SELECT 
    u.email
FROM 
    usuarios u
JOIN 
    posts p ON u.id = p.usuario_id
GROUP BY 
    u.email
ORDER BY 
    COUNT(p.id) DESC
LIMIT 1;

--- Muestra la fecha del último post de cada usuario. ---

SELECT 
    u.email,
    MAX(p.fecha_creacion)::DATE AS ultima_fecha_post
FROM 
    usuarios u
JOIN 
    posts p ON u.id = p.usuario_id
GROUP BY 
    u.email;

--- Post con más comentarios ---

SELECT 
    p.titulo,
    p.contenido
FROM 
    posts p
JOIN 
    comentarios c ON p.id = c.post_id
GROUP BY 
    p.id
ORDER BY 
    COUNT(c.id) DESC
LIMIT 1;

--- Posts con sus comentarios y autores ---

SELECT 
    p.titulo,
    p.contenido AS contenido_post,
    c.contenido AS contenido_comentario,
    u.email AS autor_comentario
FROM 
    posts p
JOIN 
    comentarios c ON p.id = c.post_id
JOIN 
    usuarios u ON c.usuario_id = u.id;

--- Último comentario por usuario --- 

SELECT 
    c.usuario_id,
    c.contenido,
    c.fecha_creacion::DATE AS fecha_creacion
FROM 
    comentarios c
JOIN (
    SELECT 
        usuario_id,
        MAX(fecha_creacion) AS ultima_fecha
    FROM 
        comentarios
    GROUP BY 
        usuario_id
) ultimos ON c.usuario_id = ultimos.usuario_id 
         AND c.fecha_creacion = ultimos.ultima_fecha;


--- Emails de usuarios sin comentarios --- 

SELECT 
    u.email
FROM 
    usuarios u
LEFT JOIN 
    comentarios c ON u.id = c.usuario_id
GROUP BY 
    u.email
HAVING 
    COUNT(c.id) = 0;







