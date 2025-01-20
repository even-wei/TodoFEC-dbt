#! /bin/bash

# Install poetry package
poetry install --no-root

# Install dbt dependencies
poetry run dbt deps

# Download duckdb file
gh repo set-default DataRecce/jaffle_shop_duckdb
branch=$(git branch --show-current)
run_id=$(gh run list --workflow "Recce CI" --branch $branch --status success --limit 1 --json databaseId --jq '.[0].databaseId')
gh run download $run_id -n duckdb

# Exec Recce
poetry run recce server --cloud --review
