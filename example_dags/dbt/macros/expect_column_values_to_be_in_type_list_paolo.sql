{%- test expect_column_values_to_be_in_type_list_paolo(model, table_name, column_name, column_type_list) -%}
{%- if execute -%}

    with validation as (
        select col_type from pg_get_cols( '{{ table_name }}' )
        cols(view_schema name, view_name name, col_name name, col_type varchar, col_num int)
        where col_name = LOWER('{{ column_name }}')
    ),
    validation_errors as(
        select count(*) as trovato
        from validation
        where 
        {% for col_type in column_type_list %}
            {% if loop.index == column_type_list|length %}
                col_type LIKE '{{col_type}}' 
            {% else %}
                col_type LIKE '{{col_type}}' OR 
            {% endif %}
        {% endfor %}
    )
    select *
    from validation_errors
    where trovato = 0
    
{%- endif -%}
{%- endtest -%}