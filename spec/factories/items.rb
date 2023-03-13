FactoryBot.define do
  factory :item do
    association :user
    price                 { Faker::Number.between(from: 299, to: 10_000_000) }
    item_name             { Faker::Name.initials(number: 2) }
    item_explanation      { Faker::Name.initials(number: 10) }
    category_id           { 2 }
    description_id        { 2 }
    charge_id             { 2 }
    prefecture_id         { 2 }
    day_id                { 2 }

    after(:build) do |message|
      message.image.attach(io: File.open('public/ER.png'), filename: 'ER.png')
    end
  end
end
