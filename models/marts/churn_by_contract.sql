with customers as (

    select * from {{ ref('stg_customers') }}

),

aggregated as (

    select
        contract,
        count(*)                                                as total_customers,
        sum(case when is_churned then 1 else 0 end)             as churned_customers,
        round(
            100.0 * sum(case when is_churned then 1 else 0 end)
            / count(*), 2
        )                                                       as churn_rate_pct,
        round(avg(monthly_charges), 2)                          as avg_monthly_charges,
        round(avg(tenure), 1)                                   as avg_tenure_months

    from customers
    group by contract

)

select * from aggregated
order by churn_rate_pct desc
