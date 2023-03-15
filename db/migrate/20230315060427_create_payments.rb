class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.string :postcode,              null: false
      t.string :sityouson,             null: false
      t.string :banchi,                null: false
      t.integer :prefecture_id,        null: false
      t.string :build_name,            null: false
      t.string :tell_number,           null: false
      t.references :purchase,          null: false, foreign_key: true
      t.timestamps
    end
  end
end