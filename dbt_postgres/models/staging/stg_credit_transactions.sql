with source as ( 
    select * from {{ source('public', 'raw_credit_transactions') }}
),

renamed as (
    select
        id,
        user_id,
        cast(amount as numeric(10,2)) as amount,
        status,
        created_at,
        (status = 'approved') as is_approved
    from source
    where created_at is not null
)

select * from renamed
