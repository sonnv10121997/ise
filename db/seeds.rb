File.open("app/uploaders/avatar.jpg") do |file|
  User.types.keys.each_with_index do |type, index|
    name = index.zero? ? "Administrator" : type
    code = Faker::Lorem.characters(2).upcase << Faker::Number.number(6)
    user = User.new
    user.build_avatar.file = file
    user.update_attributes name: name, email: "#{type.downcase}@fpt.edu.vn",
      type: type, password: "123456", gender: Faker::Number.within(0..1),
      code: code, phone: Faker::Number.leading_zero_number(10), dob: Date.today,
      confirmed_at: Date.today
    user.save!
  end
end

Major.create! name: "English", acronym: "EN"
Major.create! name: "Japanse", acronym: "JP"
Major.create! name: "Software Engineering", acronym: "SE"
Major.create! name: "Business", acronym: "SB"

6.times do
  Partner.create! name: Faker::University.unique.name, country: Faker::Nation.nationality,
    address: Faker::Address.full_address
  Requirement.create! name: Faker::Food.unique.dish
end

File.open("app/uploaders/event_thumbnail.jpg") do |file|
  20.times do |event_idx|
    event = Event.new
    event.build_thumbnail.file = file
    event.update_attributes name: Faker::Lorem.sentence(10),
      description: Faker::Lorem.paragraph(100), price: Faker::Number.decimal(8, 2),
      max_participants: 30, start_date: Date.today, end_date: Date.today + 2.week,
      semester: "Spring 2019", partner_id: Faker::Number.within(1..6), leader_id: 3,
      status: Event.statuses.values[1]
    event.event_majors.new event_id: event_idx + 1, major_id: Faker::Number.within(1..4)
    6.times do |idx|
      event.requirement_details.new event_id: event_idx + 1, deadline: Date.today + 1.week,
        requirement_id: idx + 1, description: Faker::Lorem.sentence(10)
    end
    event.save!
  end
end
