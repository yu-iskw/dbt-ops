# dbt-data-privacy

This dbt package enables us to analyze dbt projects.

<!-- toc -->
<!-- tocstop -->

## Installation Instructions

Check [dbt Hub](https://hub.getdbt.com/yu-iskw/dbt_unittest/latest/) for the latest installation instructions.

## Supported dbt versions

- dbt-core: 1.5.0 or later

## Macros

### get_unreferenced_sources

- [get_unreferenced_sources.sql](./macros/public/get_unreferenced_sources.sql)
- [get_unreferenced_sources.yml](./macros/public/get_unreferenced_sources.yml)

```
dbt run-operation get_unreferenced_sources
```
