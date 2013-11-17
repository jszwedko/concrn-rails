def create_reports
    p 'Seeding Reports...'
    Report.destroy_all

    15.times do
      address = Faker::Address
      Report.create({
        name: Faker::Name.name,
        phone: Faker::PhoneNumber.cell_phone,
        lat: 37.920556 + (rand() * (rand() > 0.5 ? -1 : 1)),
        long: 122.416667 + (rand() * (rand() > 0.5 ? -1 : 1)),
        address: address.street_address,
        age: "Young Adult",
        gender: "Male",
        race: "Caucasian",
        nature: Faker::Company.bs
        })
    end
end

def create_accounts
    p 'Seeding Teammates...'
    User.destroy_all
    Dispatcher.create!(name: 'Dan', email: 'dan@example.com', password: 'password')
    Dispatcher.create!(name: 'Doug', email: 'dbmarks@gmail.com', password: 'password')
    Responder.create!(name: 'Jacob', email: 'jacobcsavage@gmail.com', password: 'password', phone: '6502481396')
    Responder.create!(name: 'Gavin', email: 'quavmo@gmail.com', password: 'password', phone: '6507876770')

    create_responders
end

def create_responders
    p 'Seeding Responders...'
    15.times do
      Responder.create!(
        name: Faker::Name.name,
        phone: Faker::PhoneNumber.cell_phone,
        email: Faker::Internet.email,
        password: "password",
        password_confirmation: "password"
      )
    end
end

create_reports
create_accounts
