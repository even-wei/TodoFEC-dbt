# TodoFEC-dbt

This project aligns with the [**TodoFEC**](https://github.com/DataRecce/TodoFEC) initiative to create a standardized set of data tasks for comparing data processing frameworks. Our focus is on developing dbt models that transform and analyze the U.S. Election Campaign Finance dataset to provide insights into campaign contributions, expenditure patterns, and donor networks.

## Quickstart

- Explore data by Query FEC Data on S3 with DuckDB
- Once you decide what changes you want to make, you can download the dataset and make dbt model changes.

### Query FEC Data on S3 with DuckDB

The [FEC data](https://www.fec.gov/data/browse-data/?tab=bulk-data) for this project is available as Parquet files in an [**S3 bucket**](https://us-east-1.console.aws.amazon.com/s3/buckets/datarecce-todofec?bucketType=general&region=us-east-1&tab=objects#), allowing direct querying without downloading. You can use DuckDB to query the data directly.

1. Install duckdb

``` bash
   pip install duckdb
```

2. Open duckdb

``` bash
   duckdb
```

3. Run a Query: Use the following command to query the Parquet file directly from S3

``` bash
  select count(*) from read_parquet('s3://datarecce-todofec/pac_summary_2024.parquet');
```

Here are the S3 URIs of available dataset:

```
s3://datarecce-todofec/all_candidates_2024.parquet
s3://datarecce-todofec/candidate_master_2024.parquet
s3://datarecce-todofec/candidate_committee_linkage_2024.parquet
s3://datarecce-todofec/house_senate_2024.parquet
s3://datarecce-todofec/committee_master_2024.parquet
s3://datarecce-todofec/pac_summary_2024.parquet
s3://datarecce-todofec/contributions_from_committees_to_candidates_2024.parquet
s3://datarecce-todofec/operating_expenditures_2024.parquet
```

Check out [TodoFEC-parser](https://github.com/DataRecce/TodoFEC-parser) to see how the parquet files are prepared.

### Get Ready to Make dbt Model Changes

#### Fork This Repository

To make and track your changes, first fork this repository to your own GitHub account. This will create a personal copy that you can modify.

1. Fork the Repository: Click "Fork" at the top of this GitHub page.
2. Clone Your Fork:

``` bash
  git clone https://github.com/your-username/TodoFEC-dbt.git
  cd TodoFEC-dbt
```

#### System Prequisites

Before you begin you'll need the following on your system:

- Python >=3.12 (see [here](https://www.python.org/downloads/))
- Python Poetry >= 1.8 (see [here](https://pypi.org/project/poetry/))
- NPM >= 7 (see [here](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm))
- git (see [here](https://github.com/git-guides/install-git))

#### Setup dependencies

Install the python dependencies

``` bash
poetry install
```

#### Using the poetry environment

Once installation has completed you can enter the poetry environment.

```bash
poetry shell
```

### Running dbt

Once you've updated any models you can run dbt _within the poetry environment_ by simply calling:

```bash
dbt run
```

### Visualize with Evidence

#### Setup Evidence
``` bash
npm --prefix ./evidence install
```

#### Prepare data
``` bash
dbt seed -t prod   # Optional
dbt build -t prod  # Optional
npm --prefix ./evidence run sources
```

#### Launch Evidence
``` bash
npm --prefix ./evidence run dev
```

![evidence](./gif/advocacy_opposition.gif)


### Validate model changes with Recce

[Recce](https://github.com/DataRecce/recce) is a data-validation toolkit.

### Prepare the environment

Once you've updated models, you can use Recce to validate changes

``` bash
# Prepare the base environment
git checkout main
dbt seed -t prod --target-path target-base
dbt run -t prod --target-path target-base
dbt docs generate -t prod --target-path target-base

# Prepare the currnt environment
git checkout <feature_branch>
dbt seed
dbt run
dbt docs generate

# Launch Recce
recce server
```

<a href="https://datarecce.io"><img src="https://datarecce.io/assets/images/readme/recce-overview-screenshot.png" style="width: 100%; max-width: 600px; display: block; margin: 0 auto 20px;" /></a>
