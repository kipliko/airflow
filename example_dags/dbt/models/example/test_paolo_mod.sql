{{ config(materialized='table') }}

SELECT "name", altezza, last_update, boh
FROM {{ source('global_brazil_ceara', 'test_dbt_snapshot') }}