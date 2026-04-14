# Telecom Customer Churn Analysis — dbt Project

A dbt project that transforms raw telecom customer data into churn
reporting models to help identify why customers leave.

## Tech Stack
- dbt (data build tool)
- PostgreSQL

## Project Structure

models/
├── staging/
│   ├── stg_customers.sql
│   └── stg_zip_population.sql
└── marts/
    ├── churn_by_contract.sql
    ├── churn_by_internet_service.sql
    ├── churn_by_payment_method.sql
    └── churn_summary.sql

## Models

| Model | Description |
|-------|-------------|
| stg_customers | Cleans raw customer data and casts churn to boolean |
| stg_zip_population | Cleans zip code population lookup table |
| churn_by_contract | Churn rate grouped by contract type |
| churn_by_internet_service | Churn rate grouped by internet service type |
| churn_by_payment_method | Churn rate grouped by payment method |
| churn_summary | Full churn summary joined with zip population |

## How to Run

dbt seed
dbt run
dbt test
