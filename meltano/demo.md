# Level 1

There's a csv [customers.csv](data/customers.csv) with

- customer names, e-mail adresses and IPs
- you're going to extract this CSV and load it into an SQL-database.

Go ahead, just run

> `meltano run tap-csv hide-ips target-duckdb`

And that's it, you're done. Don't believe us? You can use a helper function to check the SQL-database:

> `./meltano_tut select_db`

Watch out for these things:

1. There are no ip addresses inside the database, right? Check [customers.csv](data/customers.csv), they were there.
2. That's because we added a "mapper" called "hide-ips" that is completely customizable and in this case hashes the IP addresses.
3. In the console output - Meltano told you at the beginning of the log ... "Schema 'raw' does not exist."
4. That is because Meltano has a lot of helper functions. It e.g. creates schemas and tables, should they not already exist.

Feel free to explore the project, or dive right into building it yourself!

#### Step 1 - initialize a new meltano project

Inside the terminal (bottom window) run:

> `./meltano_tut init`

This runs a wrapped "meltano init", adding demo data for you to have fun with. This will _remove_ what we preinstalled, so now we need to add a few things first.

#### Step 2 - add your first extractor

Add your first extractor to get data from the CSV. Do so by running inside the terminal:

> `meltano add extractor tap-csv`

Then open up the file `meltano.yml`, copy the config below, and paste it below `pip_url`.

```yaml
config:
  files:
    - entity: raw_customers
      path: data/customers.csv
      keys: [id]
```

Your complete config for tap-csv in `meltano.yml` should look like this:

```yaml
plugins:
  extractors:
    - name: tap-csv
      variant: meltanolabs
      pip_url: git+https://github.com/MeltanoLabs/tap-csv.git
      config:
        files:
          - entity: raw_customers
            path: data/customers.csv
            keys: [id]
```

#### Step 3 - test run your tap

Let's test the tap by running:

> `meltano invoke tap-csv`

If everything works as expected, Meltano should extract the CSV and dump it as a "stream" onto standard output inside the terminal.

#### Step 4 - add a loader

Next add a loader to load our data into a local duckdb:

> `meltano add loader target-duckdb`

Copy the configuration below and paste it below the `pip_url` for target-duckdb in the `meltano.yml` file.

```yaml
config:
  filepath: output/my.duckdb
  default_target_schema: raw
```

The config in `meltano.yml` for target-duckdb should look like this:

```yaml
loaders:
  - name: target-duckdb
    variant: jwills
    pip_url: target-duckdb~=0.4
    config:
      filepath: output/my.duckdb
      default_target_schema: raw
```

### Step 5 - run your EL pipeline

Now you can do your first complete EL run by calling `meltano run`!

> `meltano run tap-csv target-duckdb`

Perfect!

### Step 6 - view loaded data

To view your data you can use our little helper:

> `./meltano_tut select_db`

This will run a `SELECT * FROM public.raw_customers` on your duckdb instance and write the output to the terminal.

Great! You've completed your first extract and load run. 🥳

PS. If you liked what you saw, don't forget to [star us on GitHub](https://github.com/meltano/meltano) and consider joining our [Slack community](https://meltano.com/slack)!

---

# Level 2

In level 2 of the demo you will:

- remove the plain text IP adresses from the database
- create a named job to make calling your new pipeline easier

## Step 1 - Add the transform-field mapper

Notice that the data you just viewed had plain IP adresses inside of it? Let's quickly get rid of those!

Add a "mapper" to do slight modifications on the data we're sourcing here.

> `meltano add mapper transform-field`

## Step 2 - Configure the mapper to remove plain text IP adresses

Now paste the following config below the `pip_url` for the `transform-field` mapper in your `meltano.yml` file.

```yaml
mappings:
  - name: hide-ips
    config:
      transformations:
        - field_id: 'ip_address'
          tap_stream_name: 'raw_customers'
          type: 'HASH'
```

The full configuration for the mapper `transform-field` should look like this:

```yaml
mappers:
  - name: transform-field
    variant: transferwise
    pip_url: pipelinewise-transform-field
    executable: transform-field
    mappings:
      - name: hide-ips
        config:
          transformations:
            - field_id: 'ip_address'
              tap_stream_name: 'raw_customers'
              type: 'HASH'
```

## Step 3 - Add a job name to your pipeline

You already know how `meltano run` kind of works. So let's wrap the steps of the pipeline behind the run command into a "job" so we can call it with just one word.

Run:

> `meltano job add el_without_ips --tasks "[tap-csv hide-ips target-duckdb]"`

This will add the following line into your meltano.yml file:

```yaml
jobs:
- name: el_without_ips
 tasks:
 - tap-csv hide-ips target-duckdb
```

Now let's re-run our pipeline

## Step 4 - Run the pipeline calling the job

Now simply run the "job":

> `meltano run el_without_ips`

## Step 5 - Check that it worked

To view the data again, run the helper again:

> `./meltano_tut select_db`

## Step 6 - Celebrate your success 🎉

That was fun and quick! Now try to run

> `meltano dragon`

just for the fun of it! 🐉

---

# Level 3

### Full table all in

Starting with the most basic and simple replication method

### Step 1: delete one line, and run again.

delete first line and run again:

```
1,Ethe,Book,ebook0@twitter.com,67.61.243.220
```

It will loading 28 rows into 'raw."raw_customers"', but Ethe is still there...

### Step2: Add a line:

```
30,Ethe_is_back,Book,ebook0@twitter.com,67.61.243.220
```

run again

```shell
meltano run el_without_ips
./meltano_tut select_db
```

(now has 30 entries!)

### Step3: add metadata

Set `add_metadata_columns` to `True`:

```yaml
loaders:
  - name: target-duckdb
    variant: jwills
    pip_url: target-duckdb~=0.4
    config:
      filepath: output/my.duckdb
      default_target_schema: raw
      add_metadata_columns: true
```

Then delete line:

```
29,Edie,Corderoy,ecorderoys@nationalgeographic.com
```

run again.

### Step 4: add hard delete

```yaml
- name: target-duckdb
  variant: jwills
  pip_url: target-duckdb~=0.4
  config:
    filepath: output/my.duckdb
    default_target_schema: raw
    add_metadata_columns: true
    hard_delete: true
```

run again.
