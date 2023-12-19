# dbt-ops

This dbt package enables us to analyze dbt projects.

<!-- toc -->

- [Installation Instructions](#installation-instructions)
- [Compatibility with dbt Versions and Adapters](#compatibility-with-dbt-versions-and-adapters)
- [Macros](#macros)
  * [get_unreferenced_sources](#get_unreferenced_sources)

<!-- tocstop -->

## Installation Instructions

Check [dbt Hub](https://hub.getdbt.com/yu-iskw/dbt_unittest/latest/) for the latest installation instructions.

## Compatibility with dbt Versions and Adapters

This package is designed to work seamlessly with all dbt adapters, ensuring broad compatibility across different databases and SQL dialects.

We have verified that this package functions correctly with dbt Core version 1.5.0 and newer. If you're using an older version of dbt, please consider upgrading to take full advantage of this package's capabilities.

## Macros

### get_unreferenced_sources

This macro returns a list of unreferenced sources.

- [get_unreferenced_sources.sql](./macros/public/get_unreferenced_sources.sql)
- [get_unreferenced_sources.yml](./macros/public/get_unreferenced_sources.yml)

```shell
dbt run-operation get_unreferenced_sources
```
