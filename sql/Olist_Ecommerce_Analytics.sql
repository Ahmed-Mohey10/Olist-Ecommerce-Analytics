-- customer orders

create view customer_orders as
select c.customer_id,
     count(o.order_id) as order_count
from dbo.customers c
join dbo.orders o
    on c.customer_id = o.customer_id
group by c.customer_id;


-- sales summary

create view vw_salessummary as
select sum(price) as total_price,
       count(distinct order_id) as total_orders,
       count(order_item_id) as total_items,
       sum(price) / count(distinct order_id) as avg_per_order,
       sum(freight_value) as total_freights
from dbo.order_items;


-- monthly sales

create view vw_monthlysales as
select sum(o.price) as total_sales,
      format(d.order_purchase_timestamp, 'yyyy-MM') as sales_month
from dbo.order_items o
join dbo.orders d
    on o.order_id = d.order_id
group by format(d.order_purchase_timestamp, 'yyyy-MM');


-- category sales

create view vw_categoriessales as
select sum(o.price) as total_sales,
       p.product_category_name
from dbo.order_items o
join dbo.products p
    on o.product_id = p.product_id
group by p.product_category_name;


-- state sales

create view vw_statessales as
select c.customer_state,
       sum(i.price) as total_sales
from dbo.order_items i
join dbo.orders o
    on i.order_id = o.order_id
join dbo.customers c
    on o.customer_id = c.customer_id
group by c.customer_state;


-- city sales

create view vw_cityssales as
select c.customer_city,
       sum(i.price) as total_sales
from dbo.order_items i
join dbo.orders o
    on i.order_id = o.order_id
join dbo.customers c
    on o.customer_id = c.customer_id
group by c.customer_city;


create view vw_Number_customers as
select count(distinct customer_unique_id) as Number_customers
from dbo.customers;


          -- customers analysis


-- repeat customers

create view customer_orders2 as
select
    c.customer_unique_id,
    count(o.order_id) as order_count
from dbo.customers c
join dbo.orders o
    on c.customer_id = o.customer_id
group by c.customer_unique_id
having count(o.order_id) > 1;


-- total customers

create view vw_totalcustomers as
select count(distinct customer_unique_id) as total_customers
from dbo.customers;


-- total customer records

create view vw_totalcustomerrecords as
select count(customer_id) as total_customer_records
from dbo.customers;


-- customers by state

create view vw_customersbystate as
select
    customer_state,
    count(distinct customer_unique_id) as customers
from dbo.customers
group by customer_state;


-- customers by city

create view vw_customersbycity as
select
    customer_city,
    count(distinct customer_unique_id) as customers
from dbo.customers
group by customer_city;


-- repeat customers

create view vw_repeatcustomers as
select
    c.customer_unique_id,
    count(o.order_id) as order_count
from dbo.customers c
join dbo.orders o
    on c.customer_id = o.customer_id
group by c.customer_unique_id
having count(o.order_id) > 1;


-- top customers by orders

create view vw_topcustomers as
select
    c.customer_unique_id,
    count(o.order_id) as order_count
from dbo.customers c
join dbo.orders o
    on c.customer_id = o.customer_id
group by c.customer_unique_id;


-- customers and orders by state

create view vw_customersordersbystate as
select
    c.customer_state,
    count(o.order_id) as total_orders,
    count(distinct c.customer_unique_id) as customers
from dbo.customers c
join dbo.orders o
    on c.customer_id = o.customer_id
group by c.customer_state;

                      -- products analysis


-- total products

create view vw_totalproducts as
select count(product_id) as total_products
from dbo.products;


-- products by category

create view vw_productsbycategory as
select
    product_category_name,
    count(product_id) as product_count
from dbo.products
group by product_category_name;


-- sales by category

create view vw_productssalesbycategory as
select
    p.product_category_name,
    sum(i.price) as total_sales
from dbo.products p
join dbo.order_items i
    on p.product_id = i.product_id
group by p.product_category_name;


-- items sold by category

create view vw_itemssoldbycategory as
select
    p.product_category_name,
    count(i.order_item_id) as items_sold
from dbo.products p
join dbo.order_items i
    on p.product_id = i.product_id
group by p.product_category_name;


-- average price by category

create view vw_avgpricebycategory as
select
    p.product_category_name,
    avg(i.price) as avg_price
from dbo.products p
join dbo.order_items i
    on p.product_id = i.product_id
group by p.product_category_name;


-- average freight by category

create view vw_avgfreightbycategory as
select
    p.product_category_name,
    avg(i.freight_value) as avg_freight
from dbo.products p
join dbo.order_items i
    on p.product_id = i.product_id
group by p.product_category_name;

                        -- sellers analysis


-- total sellers

create view vw_totalsellers as
select count(seller_id) as total_sellers
from dbo.sellers;


-- sellers by state

create view vw_sellersbystate as
select
    seller_state,
    count(seller_id) as sellers
from dbo.sellers
group by seller_state;


-- sales by seller

create view vw_salesbyseller as
select
    s.seller_id,
    sum(i.price) as total_sales
from dbo.sellers s
join dbo.order_items i
    on s.seller_id = i.seller_id
group by s.seller_id;


-- items sold by seller

create view vw_itemssoldbyseller as
select
    s.seller_id,
    count(i.order_item_id) as items_sold
from dbo.sellers s
join dbo.order_items i
    on s.seller_id = i.seller_id
group by s.seller_id;


-- average price by seller

create view vw_avgpricebyseller as
select
    s.seller_id,
    avg(i.price) as avg_price
from dbo.sellers s
join dbo.order_items i
    on s.seller_id = i.seller_id
group by s.seller_id;


-- average freight by seller

create view vw_avgfreightbyseller as
select
    s.seller_id,
    avg(i.freight_value) as avg_freight
from dbo.sellers s
join dbo.order_items i
    on s.seller_id = i.seller_id
group by s.seller_id;


-- seller sales ranking

create view vw_sellersalesranking as
select
    s.seller_id,
    sum(i.price) as total_sales
from dbo.sellers s
join dbo.order_items i
    on s.seller_id = i.seller_id
group by s.seller_id;

                         -- payments analysis


-- total payment value

create view vw_totalpaymentvalue as
select sum(payment_value) as total_payment_value
from dbo.order_payments;


-- total payment records

create view vw_totalpaymentrecords as
select count(*) as total_payment_records
from dbo.order_payments;


-- payment methods

create view vw_paymentmethods as
select
    payment_type,
    count(*) as payment_count
from dbo.order_payments
group by payment_type;


-- payment value by method

create view vw_paymentvaluebymethod as
select
    payment_type,
    sum(payment_value) as total_payment_value
from dbo.order_payments
group by payment_type;


-- average payment and installments

create view vw_paymentanalysis as
select
    payment_type,
    avg(payment_value) as avg_payment_value,
    avg(cast(payment_installments as decimal(10,2))) as avg_installments
from dbo.order_payments
group by payment_type;

alter view vw_MonthlySales as
select
    sum(O.price) as total_sales,
    datefromparts(
        year(D.order_purchase_timestamp),
        month(D.order_purchase_timestamp),
        1
    ) as sales_month
from dbo.order_items O
join dbo.orders D
    on O.order_id = D.order_id
group by
    datefromparts(
        year(D.order_purchase_timestamp),
        month(D.order_purchase_timestamp),
        1
    );
    create view vw_monthlysales2 as
select
    datefromparts(
        year(D.order_purchase_timestamp),
        month(D.order_purchase_timestamp),
        1
    ) as sales_month,
    sum(O.price) as total_sales
from dbo.order_items O
join dbo.orders D
    on O.order_id = D.order_id
group by
    datefromparts(
        year(D.order_purchase_timestamp),
        month(D.order_purchase_timestamp),
        1
    );

    create view vw_salesbystate as
select
    C.customer_state,
    sum(I.price) as total_sales
from dbo.order_items I
join dbo.orders O
    on I.order_id = O.order_id
join dbo.customers C
    on O.customer_id = C.customer_id
group by C.customer_state;
