with a as ( SELECT 
  CASE 
       WHEN age BETWEEN 16 AND 25 THEN '16-25'
       WHEN age BETWEEN 26 AND 40 THEN '26-40'
       ELSE '40+'
  END AS age_category
        FROM customers)
SELECT age_category, COUNT(*) AS count
FROM a 
group by 1
order by 1;

select TO_CHAR(sale_date, 'YYYY-MM') AS selling_month, 
count(customer_id) as total_customers,  
round(sum(s.quantity * p.price), 0) as income
from public.sales s
join employees e 
on e.employee_id = s.sales_person_id 
join products p 
on p.product_id = s.product_id
group by 1
order by 1;

select CONCAT(c.first_name, ' ', c.last_name) AS customer,
MIN(s.sale_date) AS first_purchase_date,
CONCAT(e.first_name, ' ', e.last_name) AS seller
from public.sales s
join products p 
on p.product_id = s.product_id 
join customers c   
on c.customer_id = s.customer_id 
join employees e 
on e.employee_id = s.sales_person_id 
where price = 0
group by 1, 3, c.customer_id 
order by c.customer_id;