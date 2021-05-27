#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
"""
This is an example dag for using the Kubernetes Executor.
"""
import os

from airflow import DAG
from libs.helper import print_stuff
from airflow.operators.python_operator import PythonOperator
from airflow.utils.dates import days_ago
from datetime import datetime, timedelta


default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "start_date": datetime(2021, 5, 26),
    "email": ["airflow@airflow.com"],
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5)
}

dag = DAG("example_kubernetes_executor_paolo", default_args=default_args, schedule_interval=timedelta(1), tags=['example', 'example2'])


def process(p1):
    print(p1)
    return 'done'

start_task = PythonOperator(
    task_id="start_task", 
    python_callable=process, 
    dag=dag
)

one_task = PythonOperator(
    task_id="one_task",
    python_callable=process,
    executor_config={"KubernetesExecutor": {"image": "ubuntu"}},
    dag=dag
)

start_task >> [one_task]
    