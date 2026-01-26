## データベース設計

### users
| Column             | Type     | Options                   |
| ------------------ | -------- | ------------------------- |
| id                 | bigint   | primary key               |
| nickname           | string   | null: false               |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| first_name         | string   | null: false               |
| last_name          | string   | null: false               |
| first_name_kana    | string   | null: false               |
| last_name_kana     | string   | null: false               |
| birthday           | date     | null: false               |
| created_at         | datetime | null: false               |
| updated_at         | datetime | null: false               |

#### Association
- has_many :items
- has_many :orders

---

### items
| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| id              | bigint     | primary key                    |
| user            | references | null: false, foreign_key: true | 
| name            | string     | null: false                    |
| description     | text       | null: false                    |
| price           | integer    | null: false                    |
| category_id     | integer    | null: false                    |
| condition_id    | integer    | null: false                    |
| shipping_fee_id | integer    | null: false                    |
| prefecture_id   | integer    | null: false                    |
| shipping_day_id | integer    | null: false                    |
| created_at      | datetime   | null: false                    |
| updated_at      | datetime   | null: false                    |

#### Association
- belongs_to :user
- has_one :order

---

### orders
| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| id         | bigint     | primary key                    |
| user       | references | null: false, foreign_key: true |
| item       | references | null: false, foreign_key: true |
| created_at | datetime   | null: false                    |
| updated_at | datetime   | null: false                    |

#### Association
- belongs_to :user
- belongs_to :item
- has_one :address

---

### addresses
| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| id            | bigint     | primary key                    |
| order         | references | null: false, foreign_key: true |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |
| created_at    | datetime   | null: false                    |
| updated_at    | datetime   | null: false                    |

#### Association
- belongs_to :order
