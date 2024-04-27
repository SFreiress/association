puts "Destroying existing records..."
User.destroy_all
Person.destroy_all
Debt.destroy_all
Payment.destroy_all

User.create email: 'marcos@admin.com', password: '123456'

100.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 6)
  )
  puts "Usuario cadastrado com sucesso!"
end


100.times do
  Person.create!(
    name: Faker::Name.name,
    phone_number: Faker::PhoneNumber.phone_number,
    national_id: CPF.generate,
    active: Faker::Boolean.boolean,
    user: User.order('random()').first
  )
  puts "Cliente cadastrado com sucesso!)"
end

100.times do
  person = Person.order("RANDOM()").first
  Debt.create!(
    person: person,
    amount: Faker::Number.decimal(l_digits: 2),
    observation: Faker::Lorem.sentence
  )
  puts "Debito lançado com sucesso!"
end

100.times do
  person = Person.order("RANDOM()").first
  Payment.create!(
    person: person,
    amount: Faker::Number.decimal(l_digits: 2),
    paid_at: Faker::Date.backward(days: 365)
  )
  puts "Pagamento realizado com sucesso!"
end

