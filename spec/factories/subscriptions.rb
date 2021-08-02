FactoryBot.define do
  factory :subscription do
    title { Faker::Lorem.sentence(word_count: 3) }
    price { Faker::Commerce.price(range: 10.0..30.0) }
    status { 0 }
    frequency { Faker::Number.between(from: 0, to: 2) }
    tea
    customer
  end
end
