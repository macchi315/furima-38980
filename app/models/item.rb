class Item < ApplicationRecord
  validates :image, presence: true
  validates :price, presence: true, numericality: { greater_than: 299, less_than: 10_000_000, only_integer: true }
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
  validates :category_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :description_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :charge_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :day_id, numericality: { other_than: 1, message: "を選択してください" }
  belongs_to :user
  has_one :order
end
