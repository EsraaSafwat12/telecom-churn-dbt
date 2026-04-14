with customers as (

    select * from {{ ref('stg_customers') }}

),

zip_pop as (

    select * from {{ ref('stg_zip_population') }}

),

joined as (

    select
        c.customer_id,
        c.zip_code,
        c.contract,
        c.internet_service,
        c.payment_method,
        c.monthly_charges,
        c.total_charges,
        c.tenure,
        c.is_churned,
        coalesce(z.population, 0)   as zip_population

    from customers c
    left join zip_pop z on c.zip_code = z.zip_code

),

summary as (

    select
        zip_code,
        zip_population,
        count(*)                                                as total_customers,
        sum(case when is_churned then 1 else 0 end)             as churned_customers,
        round(
            100.0 * sum(case when is_churned then 1 else 0 end)
            / count(*), 2
        )                                                       as churn_rate_pct,
        round(avg(monthly_charges), 2)                          as avg_monthly_charges,
        round(avg(total_charges),   2)                          as avg_total_charges,
        round(avg(tenure),          1)                          as avg_tenure_months

    from joined
    group by zip_code, zip_population

)

select * from summary
order by churn_rate_pct desc
