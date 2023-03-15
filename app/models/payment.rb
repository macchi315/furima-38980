class Payment < ApplicationRecord
  validates :postcode, presence: true
  validates :sityouson, presence: true
  validates :banchi, presence: true
  validates :buils_name, presence: true
  validates :tell_number, presence: true
  validates :prefecture_id, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  with_options presence: true do
    validates :postcode, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :tell_number, format: { with: /\A\d{10,11}\z/}
  end
  belongs_to :purchase
end