WITH source AS (

    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    SELECT *, FROM {{ source('main', 'raw_customers') }}

),

renamed AS (

    SELECT
        id AS customer_id,
        first_name,
        last_name,

    FROM source

)

SELECT *, FROM renamed
