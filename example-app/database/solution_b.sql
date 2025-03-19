-- 1. 
SELECT orders.user_id, users.user_name, orders.order_id 
FROM orders 
JOIN users ON orders.user_id = users.user_id;

-- 2. 
SELECT users.user_id, users.user_name, COUNT(orders.order_id) AS so_don_hang
FROM users
LEFT JOIN orders ON users.user_id = orders.user_id
GROUP BY users.user_id, users.user_name;

-- 3. 
SELECT orders.order_id, COUNT(order_details.product_id) AS so_san_pham
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY orders.order_id;

-- 4. 
SELECT users.user_id, users.user_name, orders.order_id, products.product_name
FROM orders
JOIN users ON orders.user_id = users.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
ORDER BY orders.order_id;

-- 5.
SELECT users.user_id, users.user_name, COUNT(orders.order_id) AS so_don_hang
FROM users
JOIN orders ON users.user_id = orders.user_id
GROUP BY users.user_id, users.user_name
ORDER BY so_don_hang DESC
LIMIT 7;

-- 6.
SELECT users.user_id, users.user_name, orders.order_id, products.product_name
FROM users
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
WHERE products.product_name LIKE '%Samsung%' OR products.product_name LIKE '%Apple%'
LIMIT 7;

-- 7. 
SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS tong_tien
FROM users
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
GROUP BY users.user_id, users.user_name, orders.order_id;

-- 8.
SELECT user_id, user_name, order_id, tong_tien FROM (
    SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS tong_tien,
           RANK() OVER (PARTITION BY users.user_id ORDER BY SUM(products.product_price) DESC) AS r
    FROM users
    JOIN orders ON users.user_id = orders.user_id
    JOIN order_details ON orders.order_id = order_details.order_id
    JOIN products ON order_details.product_id = products.product_id
    GROUP BY users.user_id, users.user_name, orders.order_id
) ranked WHERE r = 1;

-- 9. 
SELECT user_id, user_name, order_id, tong_tien FROM (
    SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS tong_tien,
           RANK() OVER (PARTITION BY users.user_id ORDER BY SUM(products.product_price) ASC) AS r
    FROM users
    JOIN orders ON users.user_id = orders.user_id
    JOIN order_details ON orders.order_id = order_details.order_id
    JOIN products ON order_details.product_id = products.product_id
    GROUP BY users.user_id, users.user_name, orders.order_id
) ranked WHERE r = 1;

-- 10. 
SELECT user_id, user_name, order_id, so_san_pham FROM (
    SELECT users.user_id, users.user_name, orders.order_id, COUNT(order_details.product_id) AS so_san_pham,
           RANK() OVER (PARTITION BY users.user_id ORDER BY COUNT(order_details.product_id) DESC) AS r
    FROM users
    JOIN orders ON users.user_id = orders.user_id
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY users.user_id, users.user_name, orders.order_id
) ranked WHERE r = 1;