# feature-samples

## Requirement

- [justfile](https://github.com/casey/just): Modern `make`
- [synth](https://github.com/getsynth/synth): Powerful declarative data generator
- [jq](https://github.com/stedolan/jq): Command-line JSON processor

## Usage

```
$ just gen ./scenarios/fraud_detection 10
[info] run synth ...
[info] generate user_account.csv ...
[info] generate user_transaction_stats.csv ...

$ csview build/fraud_detection/1637063116/out/user_account.csv
+------+--------------+--------------+------------------+-------------------+
| user | state        | credit_score | account_age_days | has_2fa_installed |
+------+--------------+--------------+------------------+-------------------+
| 1    | Arizona      | 685          | 1547             | false             |
| 2    | Hawaii       | 625          | 861              | true              |
| 3    | Arkansas     | 730          | 958              | false             |
| 4    | Louisiana    | 610          | 1570             | false             |
| 5    | South Dakota | 635          | 1953             | false             |
| 6    | Louisiana    | 710          | 32               | false             |
| 7    | New Mexico   | 645          | 37               | true              |
| 8    | Nevada       | 735          | 1627             | false             |
| 9    | Kentucky     | 650          | 88               | true              |
| 10   | Delaware     | 680          | 1687             | false             |
+------+--------------+--------------+------------------+-------------------+

$ csview build/fraud_detection/1637063116/out/user_transaction_stats.csv
+------+----------------------+-----------------------+
| user | transaction_count_7d | transaction_count_30d |
+------+----------------------+-----------------------+
| 1    | 9                    | 41                    |
| 2    | 11                   | 36                    |
| 3    | 0                    | 16                    |
| 4    | 12                   | 26                    |
| 5    | 7                    | 30                    |
| 6    | 8                    | 22                    |
| 7    | 5                    | 40                    |
| 8    | 12                   | 51                    |
| 9    | 11                   | 23                    |
| 10   | 2                    | 39                    |
+------+----------------------+-----------------------+
```
