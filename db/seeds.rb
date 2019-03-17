User.types.each do |key, value|
  User.create name: key, email: "#{key.downcase}@fpt.edu.vn",
    type: key, password: "123456", gender: Faker::Number.within(0..1),
    code: key.downcase, phone: Faker::Number.leading_zero_number(10), dob: Time.now.utc,
    confirmed_at: Time.now.utc
end

Major.create name: "English", acronym: "EN"
Major.create name: "Japanse", acronym: "JP"
Major.create name: "Software Engineering", acronym: "SE"
Major.create name: "Business", acronym: "SB"

20.times do |idx|
  Event.create name: Faker::Food.unique.dish, description: Faker::Food.description,
    price: Faker::Number.decimal(8, 2), max_participants: 30, start_date: Time.now.utc,
    end_date: Time.now.utc + 1.week, semester: "Spring 2019"
  EventMajor.create event_id: (idx + 1), major_id: Faker::Number.within(1..4)
end
