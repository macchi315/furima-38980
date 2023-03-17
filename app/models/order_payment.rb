class OrderPayment
  include ActiveModel::Model
 
  attr_accessor :user_id, :item_id, :postcode, :sityouson, :banchi, :prefecture_id, :build_name, :tell_number
 
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postcode, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :sityouson, presence: true
    validates :banchi, presence: true
    validates :build_name
    validates :tell_number, format: { with: /\A\d{10,11}\z/}
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  end

  def save
    # 寄付情報を保存し、変数donationに代入する
    #order = Order.create(item_name: item_name, nickname: nickname, day_id: day_id)
    order = Order.create(user_id: user_id, item_id: item_id)
    # 住所を保存する
    # donation_idには、変数donationのidと指定する
    Payment.create(postcode: postcode, sityouson: sityouson, banchi: banchi, prefecture_id: prefecture_id, build_name: build_name, tell_number: tell_number, order_id: order.id)
  end
end