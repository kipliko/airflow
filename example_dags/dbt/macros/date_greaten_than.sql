{% test date_greaten_than(model, column_name, datepart, interval) %}

    select count( {{ column_name }} )
    from {{ model }}
    where {{ column_name }} >= dateadd({{ datepart }}, {{ interval }}, getdate())

{% endtest %}