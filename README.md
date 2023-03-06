| Left align | Right align | Center align |
|:-----------|------------:|:------------:|
| This       |        This |     This     |
| column     |      column |    column    |
| will       |        will |     will     |
| be         |          be |      be      |
| left       |       right |    center    |
| aligned    |     aligned |   aligned    |





## Usersテーブル

| Column             | Type        | Options                  |
|:------------------:|------------:|:------------------------:|
| nickname           | String      | null: false              |
| email              | String      | null: false,unique: true |
| encrypted_password | String      | null: false              |
| last_name          | String      | null: false              |
| first_name         | String      | null: false              |
| last_name_kana     | String      | null: false              |
| first_name_kana    | String      | null: false              |
| birth              | date        | null: false              |

### Association
- has_many :items
- has_many :purchases

## itemsテーブル

| Column            | Type        | Options                        |
|:-----------------:|:-----------:|:------------------------------:|
| item_name         | String      | null: false                    |
| item_explanation  | text        | null: false                    |            
| category          | String      | null: false                    |
| description       | String      | null: false                    |
| price             | integer     | null: false                    |
| user              | references  | null: false, foreign_key: true |

### Association
- belong_to :user
- has_one   :purchase

## purchasesテーブル

| Column            | Type          | Options                        |
|:-----------------:|:-------------:|:------------------------------:|
| user              | references    | null: false, foreign_key: true |
| item              | references    | null: false, foreign_key: true |

### Association
- belong_to :user
- belong_to :item
- has_one   :payment

## paymentsテーブル

| Column            | Type          | Options                        |
|:-----------------:|:-------------:|:------------------------------:|
| postcode          | string        | null: false                    |
| todouhuken_id     | integer       | null: false                    |
| sityouson         | string        | null: false                    |
| banchi            | string        | null: false                    |
| build_name        | string        |                                |
| tell_number       | string        | null: false                    |
| user              | references    | null: false, foreign_key: true |
| item              | references    | null: false, foreign_key: true |


### Association
- belong_to :purchase