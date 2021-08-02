FactoryBot.define do
  factory :tea do
    name { Faker::Tea.variety }
    description { Faker::Coffee.notes }
    temperature { Faker::Number.between(from: 75, to: 100) }
    brew_time { Faker::Number.between(from: 1, to: 5) }
  end
end
