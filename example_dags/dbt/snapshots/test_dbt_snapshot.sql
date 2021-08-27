{% snapshot test_dbt_snapshot_snap %}

{{
    config(
      
      target_database='dreddevbiba',
      target_schema='global_brazil_ceara',
      unique_key='id',

      strategy='timestamp',
      updated_at='last_update',
      invalidate_hard_deletes=True,

    )
}}

select * from {{ source('global_brazil_ceara','test_dbt_snapshot') }}

{% endsnapshot %}