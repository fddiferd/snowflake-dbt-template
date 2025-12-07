use role accountadmin;
create warehouse if not exists transforming;
create role if not exists data_engineer;

-- Grant role to your user (replace with your username if different)
grant role data_engineer to user frankdonatodiferdinando;

create database if not exists raw;
create schema if not exists raw.jaffle_shop;
create schema if not exists raw.stripe;
create database if not exists analytics;
create schema if not exists analytics.prod;
-- Grant data_engineer full access to RAW database
grant all on database raw to role data_engineer;
grant all on all schemas in database raw to role data_engineer;
grant all on all tables in database raw to role data_engineer;
grant all on future schemas in database raw to role data_engineer;
grant all on future tables in database raw to role data_engineer;

-- Grant data_engineer full access to ANALYTICS database
grant all on database analytics to role data_engineer;
grant all on all schemas in database analytics to role data_engineer;
grant all on all tables in database analytics to role data_engineer;
grant all on future schemas in database analytics to role data_engineer;
grant all on future tables in database analytics to role data_engineer;

-- Grant warehouse usage
grant usage on warehouse transforming to role data_engineer;


-- Create tables (will be truncated and reloaded on each run)
create table if not exists raw.jaffle_shop.customers 
( id integer,
  first_name varchar,
  last_name varchar
);

create table if not exists raw.jaffle_shop.orders
( id integer,
  user_id integer,
  order_date date,
  status varchar,
  _etl_loaded_at timestamp default current_timestamp
);

create table if not exists raw.stripe.payment 
( id integer,
  orderid integer,
  paymentmethod varchar,
  status varchar,
  amount integer,
  created date,
  _batched_at timestamp default current_timestamp
);

-- Truncate tables before loading to prevent duplicates
truncate table if exists raw.jaffle_shop.customers;
truncate table if exists raw.jaffle_shop.orders;
truncate table if exists raw.stripe.payment;

-- Load data from S3
copy into raw.jaffle_shop.customers (id, first_name, last_name)
from 's3://dbt-tutorial-public/jaffle_shop_customers.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
);

copy into raw.jaffle_shop.orders (id, user_id, order_date, status)
from 's3://dbt-tutorial-public/jaffle_shop_orders.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
);

copy into raw.stripe.payment (id, orderid, paymentmethod, status, amount, created)
from 's3://dbt-tutorial-public/stripe_payments.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
);

-- test queries
select * from raw.jaffle_shop.customers;
select * from raw.jaffle_shop.orders;
select * from raw.stripe.payment;