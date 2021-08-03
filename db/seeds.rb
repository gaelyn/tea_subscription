5.times do
  Customer.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    address: Faker::Address.full_address
  )
end

5.times do
  Tea.create(
    name: Faker::Tea.variety,
    description: Faker::Coffee.notes,
    temperature: Faker::Number.between(from: 75, to: 100),
    brew_time: Faker::Number.between(from: 1, to: 5)
  )
end

5.times do
  Customer.all.sample.subscriptions.create(
    title: Faker::Lorem.sentence(word_count: 3),
    price: Faker::Commerce.price(range: 10.0..30.0),
    frequency: Faker::Number.between(from: 0, to: 2),
    tea_id: Tea.all.sample.id
  )
end
