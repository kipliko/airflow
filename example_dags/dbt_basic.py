from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta
from airflow.utils.dates import days_ago

# We're hardcoding this value here for the purpose of the demo, but in a production environment this
# would probably come from a config file and/or environment variables!
DBT_PROJECT_DIR = '/opt/airflow/dags/repo/example_dags/dbt'


dag = DAG(
    "dbt_basic_dag",
    start_date=datetime(2020, 12, 23),
    default_args={"owner": "astronomer", "email_on_failure": False},
    description="A sample Airflow DAG to invoke dbt runs using a BashOperator",
    schedule_interval=None,
    catchup=False,
)

with dag:
    # This task loads the CSV files from dbt/data into the local postgres database for the purpose of this demo.
    # In practice, we'd usually expect the data to have already been loaded to the database.
    dbt_compile = BashOperator(
        task_id="dbt_compile",
        bash_command=f"dbt compile --profiles-dir {DBT_PROJECT_DIR} --project-dir {DBT_PROJECT_DIR}"
    )
    dbt_debug = BashOperator(
        task_id="dbt_debug",
        bash_command=f"dbt debug --profiles-dir {DBT_PROJECT_DIR} --project-dir {DBT_PROJECT_DIR}"
    )
    #dbt_seed = BashOperator(
    #    task_id="dbt_seed",
    #    bash_command=f"dbt seed --profiles-dir {DBT_PROJECT_DIR} --project-dir {DBT_PROJECT_DIR}"
    #)

    #dbt_run = BashOperator(
    #    task_id="dbt_run",
    #    bash_command=f"dbt run --profiles-dir {DBT_PROJECT_DIR} --project-dir {DBT_PROJECT_DIR}"
    #)

    #dbt_test = BashOperator(
    #    task_id="dbt_test",
    #    bash_command=f"dbt test --profiles-dir {DBT_PROJECT_DIR} --project-dir {DBT_PROJECT_DIR}"
    #)

    dbt_compile >> dbt_debug
