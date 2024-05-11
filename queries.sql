select
    concat(e.first_name, ' ', e.last_name) as seller,
    count(s.sales_id) as operations,
    floor(sum(s.quantity * p.price)) as income
from sales as s
inner join employees as e
    on s.sales_person_id = e.employee_id
inner join products as p
    on s.product_id = p.product_id
group by 1
order by 1 desc
limit 10;

select
    concat(e.first_name, ' ', e.last_name) as seller,
    floor(avg(s.quantity * p.price)) as average_income
from sales as s
inner join employees as e on s.sales_person_id = e.employee_id
inner join products as p on s.product_id = p.product_id
group by seller
having
    avg(s.quantity * p.price)
    < (
        select avg(s.quantity * p.price) from sales as s
        inner join employees as e on s.sales_person_id = e.employee_id
        inner join products as p on s.product_id = p.product_id
    )
order by 2;

select
    extract(isodow from s.sale_date) as date_format,
    concat(e.first_name, ' ', e.last_name) as seller,
    to_char(s.sale_date, 'day') as day_of_week,
    floor(sum(s.quantity * p.price)) as income
from public.sales as s
inner join employees as e
    on s.sales_person_id = e.employee_id
inner join products as p
    on s.product_id = p.product_id
group by 2, 3, 1
order by 1, 2;

select
    case
        when age between 16 and 25 then '16-25'
        when age between 26 and 40 then '26-40'
        else '40+'
    end as age_category,
    count(*) as age_count
from customers
group by 1
order by 1;

select
    to_char(s.sale_date, 'YYYY-MM') as selling_month,
    count(distinct s.customer_id) as total_customers,
    floor(sum(s.quantity * p.price)) as income
from sales as s
inner join employees as e
    on s.sales_person_id = e.employee_id
inner join products as p
    on s.product_id = p.product_id
group by 1
order by 1;

select distinct on (c.customer_id)
    c.customer_id,
    s.sale_date,
    concat(c.first_name, ' ', c.last_name) as customer,
    concat(e.first_name, ' ', e.last_name) as seller
from
    sales as s
inner join
    customers as c
    on s.customer_id = c.customer_id
inner join
    employees as e
    on s.sales_person_id = e.employee_id
inner join
    products as p
    on s.product_id = p.product_id
where p.price = 0
order by 1, 2;
