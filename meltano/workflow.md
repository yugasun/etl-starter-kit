## Orchestrate Data

Most data pipelines aren’t run just once, but over and over again, to make sure additions and changes in the source eventually make their way to the destination.

To help you realize this, Meltano supports scheduled pipelines that can be orchestrated using Apache Airflow.

When a new pipeline schedule is created using the CLI, a DAG is automatically created in Airflow as well, which represents “a collection of all the tasks you want to run, organized in a way that reflects their relationships and dependencies”.

### Create a Schedule

```shell
# Define a job
meltano job add mysql2pg --tasks "tap-mysql target-postgres"

# Schedule the job
meltano schedule add mysql2pg --job mysql2pg --interval "@hourly"
```

This would add the following schedule to your meltano.yml:

```yaml
schedules:
  - name: mysql2pg
    job: mysql2pg
    interval: '@hourly'
```

### Install Airflow

Add below plugin config in `meltano.yml`:

```yaml
plugins:
  # ...
  orchestrators:
    - name: airflow
      variant: apache
      pip_url: apache-airflow==2.5 --constraint https://raw.githubusercontent.com/apache/airflow/constraints-2-5/constraints-3.10.txt
  files:
    - name: files-airflow
      variant: meltano
      pip_url: git+https://github.com/meltano/files-airflow.git
```

Then run:

```
meltano add orchestrate airflow
meltano add files files-airflow
```

### Starting the Airflow scheduler

Now that Airflow is installed and (automatically) configured to look at your project’s Meltano DAG generator, let’s start the scheduler:

```shell
meltano invoke airflow scheduler
```

Airflow will now run your pipelines on a schedule as long as the scheduler is running!

### Using Airflow directly

You are free to interact with Airflow directly through its own UI. You can start the web like this:

```shell
# init db
meltano invoke airflow db init

# create admin user:
meltano invoke airflow users create \
    --username etl \
    --password Admin@123 \
    --firstname Admin \
    --lastname Admin \
    --role Admin \
    --email etl@admin.com

# start airflow web server
meltano invoke airflow webserver
```

Now, you can access to airflow UI by `http://localhost:8080`, use below account:

```
username: etl
password: Admin@123
```

By default, you’ll only see Meltano’s pipeline DAGs here, which are created automatically using the dynamic DAG generator included with every Meltano project, located at orchestrate/dags/meltano.py.

You can use the bundled Airflow with custom DAGs by putting them inside the orchestrate/dags directory, where they’ll be picked up by Airflow automatically. To learn more, check out the Apache Airflow documentation.

Meltano’s use of Airflow will be unaffected by other usage of Airflow as long as orchestrate/dags/meltano.py remains untouched and pipelines are managed through the dedicated interface.

### Trigger dags manually

```
meltano invoke airflow dags trigger meltano_mysql2pg_mysql2pg --disable-retry
```
