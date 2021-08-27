{% test expect_check_duplicates_perc(model, group_by_cols, thresholds) %}

    {% set total_rows %}
    select count( 1 ) total_rows from {{ model }}
    {% endset %}

    with validation_error as (
        select ((sum(a.ciccio)*1.0 / ( {{total_rows}} ) ) * 100) perc
        from 
        (SELECT {{ group_by_cols }}, COUNT(*)-1 ciccio
            FROM {{ model }} 
            GROUP BY {{ group_by_cols }}
            HAVING count(*) > 1) a
    )

    select *
    from validation_error
    where perc > {{ thresholds }}

{% endtest %}