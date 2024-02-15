-- QUERY-1
-- Retrieve top-selling books for the period from January 1, 2024, to January 31, 2024.
-- This query returns the ISBN, title, and total quantity sold for each book, ordered by total sold in descending order.

SELECT 
    b.isbn, 
    b.book_title, 
    SUM(oi.quantity) AS total_sold
FROM 
    order_item oi
JOIN 
    book b ON oi.book_id = b.isbn
JOIN 
    "order" o ON oi.order_id = o.id
WHERE 
    o.order_date BETWEEN '2024-01-01' AND '2024-01-31' 
    -- It can replaced with the desired range of dates
GROUP BY 
    b.isbn, 
    b.book_title
ORDER BY 
    total_sold DESC;
-- LIMIT A; We can adjust the limit to get top A selling books. Ex: LIMIT 3 will give top three selling books



-- QUERY-2
-- Calculate total sales revenue for the period from January 1, 2024, to January 31, 2024.
-- This query sums the total revenue generated from book sales within the specified period.

SELECT 
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM 
    order_item oi
JOIN 
    "order" o ON oi.order_id = o.id
WHERE 
    o.order_date BETWEEN '2024-01-01' AND '2024-01-31'; 
    -- It can replaced with the desired range of dates
