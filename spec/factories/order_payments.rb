FactoryBot.define do
  factory :order_payment do
    postcode { Faker::Number.decimal_part(digits: 3) + '-' + Faker::Number.decimal_part(digits: 4) }
    sityouson { Faker::Address.city }
    banchi { Faker::Address.street_address }
    build_name { Faker::Address.street_address }
    tell_number { Faker::Number.decimal_part(digits: 11) }
    prefecture_id { Faker::Number.between(from: 2, to: 47) }
    token { Faker::Internet.password(min_length: 20, max_length: 30) }
  end
end
