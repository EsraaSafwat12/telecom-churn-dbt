with customers as (

    select * from {{ ref('stg_customers') }}

),

aggregated as (

    select
        payment_method,
        count(*)                                                as total_customers,
        sum(case when is_churned then 1 else 0 end)             as churned_customers,
        round(
            100.0 * sum(case when is_churned then 1 else 0 end)
            / count(*), 2
        )                                                       as churn_rate_pct

    from customers
    group by payment_method

)

select * from aggregated
order by churn_rate_pct desc
