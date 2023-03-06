## usersテーブル

| Column             | Type        | Options                  |
|:------------------:|------------:|:------------------------:|
| nickname           | string      | null: false              |
| email              | string      | null: false,unique: true |
| encrypted_password | string      | null: false              |
| last_name          | string      | null: false              |
| first_name         | string      | null: false              |
| last_name_kana     | string      | null: false              |
| first_name_kana    | string      | null: false              |
| birth              | date        | null: false              |

### Association
- has_many :items
- has_many :purchases

## itemsテーブル

| Column            | Type        | Options                        |
|:-----------------:|:-----------:|:------------------------------:|
| price             | integer     | null: false                    |
| item_name         | string      | null: false                    |
| item_explanation  | text        | null: false                    |            
| category_id       | integer     | null: false                    |
| description_id    | integer     | null: false                    |
| charge_id         | integer     | null: false                    |
| prefecture_id     | integer     | null: false                    |
| day_id            | integer     | null: false                    |
| user              | references  | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one   :purchase

## purchasesテーブル

| Column            | Type          | Options                        |
|:-----------------:|:-------------:|:------------------------------:|
| user              | references    | null: false, foreign_key: true |
| item              | references    | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one   :payment

## paymentsテーブル

| Column            | Type          | Options                        |
|:-----------------:|:-------------:|:------------------------------:|
| postcode          | string        | null: false                    |
| prefecture_id     | integer       | null: false                    |
| sityouson         | string        | null: false                    |
| banchi            | string        | null: false                    |
| build_name        | string        |                                |
| tell_number       | string        | null: false                    |
| purchase          | references    | null: false, foreign_key: true |


### Association
- belongs_to :purchase