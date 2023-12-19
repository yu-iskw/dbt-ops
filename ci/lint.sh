#!/bin/bash

# Copyright 2023 yu-iskw
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

# Description: Linting script for pre-commit hooks

# Constants
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
PROJECT_DIR="$(dirname "${SCRIPT_DIR}")"

# Run pre-commit hooks
cd "$PROJECT_DIR"
pre-commit run --all-files end-of-file-fixer
pre-commit run --all-files trailing-whitespace
pre-commit run --all-files check-json
pre-commit run --all-files check-yaml
pre-commit run --all-files detect-private-key
pre-commit run --all-files actionlint-docker
pre-commit run --all-files yamllint
