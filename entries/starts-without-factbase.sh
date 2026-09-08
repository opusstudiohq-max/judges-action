#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) 2024-2026 Zerocracy
# SPDX-License-Identifier: MIT

set -e -o pipefail

SELF=$1

source "${SELF}/makes/setup-test-env.sh"
source "${SELF}/makes/test-common.sh"
setup_test_env "${SELF}" name

rm -f "${name}.fb"
test ! -e "${name}.fb"

run_entry_script "${SELF}" success \
  "GITHUB_WORKSPACE=$(pwd)" \
  "INPUT_DRY-RUN=false" \
  "INPUT_FAIL-FAST=true" \
  "INPUT_GITHUB-TOKEN=test-token" \
  "INPUT_FACTBASE=${name}.fb" \
  "INPUT_CYCLES=1" \
  "INPUT_REPOSITORIES=yegor256/factbase" \
  "INPUT_VERBOSE=true" \
  "INPUT_TOKEN=ZRCY-00000000-0000-0000-0000-000000000000"

factbase_exists "${name}" \
  "A missing factbase must be created on the first run instead of aborting at realpath"
