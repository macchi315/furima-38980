class Item < ApplicationRecord
  validates :image, presence: true
  validates :price, presence: true, numericality: { greater_than: 300, less_than: 9_999_999 }, format: { with: /\d/ }
  validates :item_name, presence: true
  validates :item_explanation, presence: true
  validates :category_id, presence: true
  validates :description_id, presence: true
  validates :prefecture_id, presence: true
  validates :charge_id, presence: true
  validates :day_id, presence: true
  validates :category_id, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :description
  belongs_to :charge
  belongs_to :prefecture
  belongs_to :day
  has_one_attached :image
  validates :item_name, :item_explanation, presence: true
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :description_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :charge_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :day_id, numericality: { other_than: 1, message: "can't be blank" }
  belongs_to :user
end
