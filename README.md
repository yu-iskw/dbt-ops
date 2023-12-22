# dbt-ops

This dbt package enables us to analyze dbt projects.

<!-- toc -->

- [Installation Instructions](#installation-instructions)
- [Compatibility with dbt Versions and Adapters](#compatibility-with-dbt-versions-and-adapters)
- [Macros](#macros)
  * [find_unreferenced_sources ([source](./macros/public/find_unreferenced_sources.sql), [property](./macros/public/find_unreferenced_sources.yml))](#find_unreferenced_sources-sourcemacrospublicfind_unreferenced_sourcessql-propertymacrospublicfind_unreferenced_sourcesyml)
  * [find_downstream_models ([source](./macros/public/find_downstream_models.sql), [property](./macros/public/find_downstream_models.yml))](#find_downstream_models-sourcemacrospublicfind_downstream_modelssql-propertymacrospublicfind_downstream_modelsyml)
  * [find_upstream_models ([source](./macros/public/find_upstream_models.sql), [property](./macros/public/find_upstream_models.yml))](#find_upstream_models-sourcemacrospublicfind_upstream_modelssql-propertymacrospublicfind_upstream_modelsyml)

<!-- tocstop -->

## Installation Instructions

Check [dbt Hub](https://hub.getdbt.com/yu-iskw/dbt_unittest/latest/) for the latest installation instructions.

## Compatibility with dbt Versions and Adapters

This package is designed to work seamlessly with all dbt adapters, ensuring broad compatibility across different databases and SQL dialects.

We have verified that this package functions correctly with dbt Core version 1.5.0 and newer. If you're using an older version of dbt, please consider upgrading to take full advantage of this package's capabilities.

## Macros

### find_unreferenced_sources ([source](./macros/public/find_unreferenced_sources.sql), [property](./macros/public/find_unreferenced_sources.yml))

This macro returns a list of unreferenced sources.

**Usage:**

```shell
dbt run-operation find_unreferenced_sources
```

### find_downstream_models ([source](./macros/public/find_downstream_models.sql), [property](./macros/public/find_downstream_models.yml))

This macro returns a list of downstream models.

**Usage:**

```shell
dbt run-operation find_downstream_nodes --args '{"unique_id": "model.integration_tests.stg_orders", "resource_types": ["model", "snapshot", "exposure"]}'

- 1: model.integration_tests.stg_orders (model:view)
  - 1.1: model.integration_tests.customers (model:view)
  - 1.5: model.integration_tests.orders (model:view)
```

### find_upstream_models ([source](./macros/public/find_upstream_models.sql), [property](./macros/public/find_upstream_models.yml))

This macro returns a list of upstream models.

**Usage:**

```shell
dbt run-operation find_upstream_nodes --args '{"unique_id": "model.integration_tests.orders", "resource_types": ["model", "snapshot", "source"]}'

- 1: model.integration_tests.orders (model:view)
  - 1.1: model.integration_tests.stg_orders (model:view)
    - 1.1.1: source.integration_tests.main.raw_orders (source)
  - 1.2: model.integration_tests.stg_payments (model:view)
    - 1.2.1: source.integration_tests.main.raw_payments (source)
```
