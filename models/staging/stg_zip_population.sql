with source as (

    select * from {{ ref('zip_code_population') }}

),

cleaned as (

    select
        zipcode                         as zip_code,
        cast(population as integer)     as population

    from source

)

select * from cleaned
