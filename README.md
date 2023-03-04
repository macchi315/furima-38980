## Usersテーブル

|Column            |Type  |Options                 |
|nickname          |String|null: false,unique: true|
|e-mail            |String|null: false,unique: true|
|password          |String|null: false,unique: true|
|encrypted_password|String|null: false,unique: true|
|last_name         |String|null: false             |
|first_name        |String|null: false             |
|last_name_kana    |String|null: false             |
|first_name_kana   |String|null: false             |
|birth             |date  |null: false             |

### Association
- has_many :items
- has_many :purchases

## itemsテーブル

|Column            |Type      |Options                       |
|image             |          |null: false                   |
|item_name         |String    |null: false                   |
|category          |String    |null: false                   |
|description       |text      |null: false                   |
|price             |integer   |null: false                   |
|user              |references|null: false, foreign_key: true|

### Association
- belong_to :user
- has_one   :purchase

## purchasesテーブル

|Column            |Type      |Options                       |
|fee               |integer   |null: false                   |
|commission        |float     |null: false                   |
|profit            |integer   |null: false                   |
|user              |references|null: false, foreign_key: true|
|item              |references|null: false, foreign_key: true|

### Association
- belong_to :user
- belong_to :item
- has_one   :payment

## paymentsテーブル

|Column          |Type     |Options    |
|postcode        |string   |null: false|
|todouhuken      |string   |null: false|
|sityouson       |string   |null: false|
|build_name      |string   |null: true |
|tell_number     |string   |null: false|

### Association
- belong_to :purchase