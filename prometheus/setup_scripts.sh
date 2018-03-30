#!/bin/bash
# Run this script from the repository top level.
echo "Setting up repository groups sync script"
sudo -u postgres psql prometheus -c "insert into gha_postprocess_scripts(ord, path) select 0, 'scripts/prometheus/repo_groups.sql' on conflict do nothing"
echo "Setting up default postprocess scripts"
PG_DB=prometheus ./runq util_sql/default_postprocess_scripts.sql
echo "Setting up repository groups postprocess script"
PG_DB=prometheus ./runq util_sql/repo_groups_postprocess_script_from_repos.sql
