#!/bin/bash
set -Eeuo pipefail

dbt run-operation test_macros
