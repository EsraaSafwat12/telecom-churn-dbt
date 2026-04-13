with source as (

    select * from {{ ref('telecom_customer_churn') }}

),

cleaned as (

    select
        customerid                                  as customer_id,
        gender,
        seniorcitizen                               as is_senior_citizen,
        partner,
        dependents,
        tenure,
        phoneservice                                as phone_service,
        multiplelines                               as multiple_lines,
        internetservice                             as internet_service,
        onlinesecurity                              as online_security,
        onlinebackup                                as online_backup,
        deviceprotection                            as device_protection,
        techsupport                                 as tech_support,
        streamingtv                                 as streaming_tv,
        streamingmovies                             as streaming_movies,
        contract,
        paperlessbilling                            as paperless_billing,
        paymentmethod                               as payment_method,
        cast(monthlycharges as numeric)             as monthly_charges,
        cast(nullif(totalcharges, '') as numeric)   as total_charges,
        case
            when upper(churn) = 'YES' then true
            else false
        end                                         as is_churned,
        zipcode                                     as zip_code

    from source

)

select * from cleaned
