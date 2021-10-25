-- Table: Sales

-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | sale_id     | int   |
-- | product_id  | int   |
-- | year        | int   |
-- | quantity    | int   |
-- | price       | int   |
-- +-------------+-------+
-- (sale_id, year) is the primary key of this table.
-- product_id is a foreign key to Product table.
-- Each row of this table shows a sale on the product product_id in a certain year.
-- Note that the price is per unit.


-- Table: Product

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | product_id   | int     |
-- | product_name | varchar |
-- +--------------+---------+
-- product_id is the primary key of this table.
-- Each row of this table indicates the product name of each product.


-- Write an SQL query that selects the product id, year, quantity, and price for the first year of every product sold.

-- Return the resulting table in any order.

-- The query result format is in the following example.



-- Example 1:

-- Input:
-- Sales table:
-- +---------+------------+------+----------+-------+
-- | sale_id | product_id | year | quantity | price |
-- +---------+------------+------+----------+-------+
-- | 1       | 100        | 2008 | 10       | 5000  |
-- | 2       | 100        | 2009 | 12       | 5000  |
-- | 7       | 200        | 2011 | 15       | 9000  |
-- +---------+------------+------+----------+-------+
-- Product table:
-- +------------+--------------+
-- | product_id | product_name |
-- +------------+--------------+
-- | 100        | Nokia        |
-- | 200        | Apple        |
-- | 300        | Samsung      |
-- +------------+--------------+
-- Output:
-- +------------+------------+----------+-------+
-- | product_id | first_year | quantity | price |
-- +------------+------------+----------+-------+
-- | 100        | 2008       | 10       | 5000  |
-- | 200        | 2011       | 15       | 9000  |
-- +------------+------------+----------+-------+
-- Accepted
-- 24,371
-- Submissions
-- 48,875

with temp as(
select p.product_id, s.year, s.quantity , s.price,
rank() over(partition by product_id order by year asc) as 'ranked'
from Sales s
    join Product p
        on s.product_id = p.product_id
)

select product_id, year as first_year , quantity , price
from temp
where ranked = 1