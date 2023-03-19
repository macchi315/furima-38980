class OrderPayment
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postcode, :sityouson, :banchi, :prefecture_id, :build_name, :tell_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postcode, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :sityouson, presence: true
    validates :banchi, presence: true
    validates :tell_number, format: { with: /\A\d{10,11}\z/ }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Payment.create(postcode: postcode, sityouson: sityouson, banchi: banchi, prefecture_id: prefecture_id,
                   build_name: build_name, tell_number: tell_number, order_id: order.id)
  end
end
