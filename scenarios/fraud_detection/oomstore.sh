#!/usr/bin/env sh

featctl register entity user --length 8 --description 'user ID'

featctl register group account --entity user --description 'user account info'
featctl register group transaction_stats --entity user --description 'user transaction stats'

featctl register batch-feature state             --group account --db-value-type "varchar(32)"
featctl register batch-feature credit_score      --group account --db-value-type "int"
featctl register batch-feature account_age_days  --group account --db-value-type "int"
featctl register batch-feature has_2fa_installed --group account --db-value-type "bool"

featctl register batch-feature transaction_count_7d  --group transaction_stats --db-value-type "int"
featctl register batch-feature transaction_count_30d --group transaction_stats --db-value-type "int"

featctl import --group account --input-file account.csv --description 'sample account data'
featctl import --group transaction_stats --input-file transaction_stats.csv --description 'sample transaction stat data'
