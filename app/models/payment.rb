class Payment < ApplicationRecord
  #validates :postcode, presence: true
  #validates :sityouson, presence: true
  #validates :banchi, presence: true
  #validates :build_name
  #validates :tell_number, presence: true
  #validates :prefecture_id, presence: true

  belongs_to :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

end