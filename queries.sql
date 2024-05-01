select concat(e.first_name, ' ', e.last_name) as seller, count(s.sales_id), sum(round(s.quantity * p.price, 0)) as income
from public.sales s
join employees e 
on e.employee_id = s.sales_person_id 
join products p 
on p.product_id = s.product_id
group by 1
order by income desc
limit 10;

with a as (select concat(e.first_name, ' ', e.last_name) as seller, sum(s.quantity * p.price) as income
from public.sales s
join employees e 
on e.employee_id = s.sales_person_id 
join products p 
on p.product_id = s.product_id
group by 1), b as (select avg(income) as avg_total from a),
c as (select seller, avg(income) as avg_sale from a group by 1)
select seller, round(avg_sale, 0) as average_income
from c 
cross join b 
where avg_sale < avg_total
order by average_income asc;

select concat(e.first_name, ' ', e.last_name) as seller, to_char(sale_date, 'Day') AS day_of_week,  sum(round(s.quantity * p.price, 0)) as income
from public.sales s
join employees e 
on e.employee_id = s.sales_person_id 
join products p 
on p.product_id = s.product_id
group by 1, 2
order by extract(ISODOW from max(s.sale_date)), 1;