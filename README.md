# feature-samples

## Requirement

- [justfile](https://github.com/casey/just): Modern `make`
- [synth](https://github.com/getsynth/synth): Powerful declarative data generator

## Usage

```
$ just gen ./scenarios/fraud_detection 10
[info] run synth ...
[info] generate user_account.csv ...
[info] generate user_transaction_stats.csv ...

$ csview build/fraud_detection/user_account.csv
+------------------+--------------+-------------------+--------------+---------+
| account_age_days | credit_score | has_2fa_installed | state        | user_id |
+------------------+--------------+-------------------+--------------+---------+
| 1547             | 685          | false             | Arizona      | 1001    |
| 861              | 625          | true              | Hawaii       | 1002    |
| 958              | 730          | false             | Arkansas     | 1003    |
| 1570             | 610          | false             | Louisiana    | 1004    |
| 1953             | 635          | false             | South Dakota | 1005    |
| 32               | 710          | false             | Louisiana    | 1006    |
| 37               | 645          | true              | New Mexico   | 1007    |
| 1627             | 735          | false             | Nevada       | 1008    |
| 88               | 650          | true              | Kentucky     | 1009    |
| 1687             | 680          | false             | Delaware     | 1010    |
+------------------+--------------+-------------------+--------------+---------+

$ csview build/fraud_detection/user_transaction_stats.csv
+-----------------------+----------------------+---------+
| transaction_count_30d | transaction_count_7d | user_id |
+-----------------------+----------------------+---------+
| 26                    | 9                    | 1001    |
| 21                    | 11                   | 1002    |
| 1                     | 0                    | 1003    |
| 11                    | 12                   | 1004    |
| 15                    | 7                    | 1005    |
| 7                     | 8                    | 1006    |
| 25                    | 5                    | 1007    |
| 36                    | 12                   | 1008    |
| 8                     | 11                   | 1009    |
| 24                    | 2                    | 1010    |
+-----------------------+----------------------+---------+
```
