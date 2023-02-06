## dbt

dbt project demo.

## Installation

```shell
pip install dbt-postgres dbt-mysql
dbt --version
```

## Usage

1. Ensure your profile is setup correctly from the command line:

```bash
dbt debug
```

2. Load the CSVs with the demo data set. This materializes the CSVs as tables in your target schema. Note that a typical dbt project **does not require this step** since dbt assumes your raw data is already in your warehouse.

```bash
dbt seed
```

3. Run the models:

```bash
dbt run
```

> **NOTE:** If this steps fails, it might mean that you need to make small changes to the SQL in the models folder to adjust for the flavor of SQL of your target database. Definitely consider this if you are using a community-contributed adapter.

4. Test the output of the models:

```bash
dbt test
```

5. Generate documentation for the project:

```bash
dbt docs generate
```

6. View the documentation for the project:

```bash
dbt docs serve
```

## More information

For more information on dbt:

- Read the [introduction to dbt](https://docs.getdbt.com/docs/introduction).
- Read the [dbt viewpoint](https://docs.getdbt.com/docs/about/viewpoint).
- Join the [dbt community](http://community.getdbt.com/).
