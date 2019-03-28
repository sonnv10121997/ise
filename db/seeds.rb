File.open("app/uploaders/avatar.jpg") do |file|
  User.types.keys.each_with_index do |type, index|
    name = index.zero? ? "Administrator" : type
    user = User.new
    user.build_avatar.file = file
    user.update_attributes name: name, email: "#{type.downcase}@fpt.edu.vn",
      type: type, password: "123456", gender: Faker::Number.within(0..1),
      code: type.downcase, phone: Faker::Number.leading_zero_number(10), dob: Date.today,
      confirmed_at: Date.today
    user.save!
  end
end

Major.create! name: "English", acronym: "EN"
Major.create! name: "Japanse", acronym: "JP"
Major.create! name: "Software Engineering", acronym: "SE"
Major.create! name: "Business", acronym: "SB"

10.times do
  Partner.create! name: Faker::University.name, country: Faker::Nation.nationality,
    address: Faker::Address.full_address
  Requirement.create! name: Faker::Food.dish, description: Faker::Lorem.paragraph(3)
end

File.open("app/uploaders/event_thumbnail.jpg") do |file|
  20.times do |event_idx|
    event = Event.new
    event.build_thumbnail.file = file
    event.update_attributes name: Faker::Lorem.sentence(10),
      description: Faker::Lorem.paragraph(100), price: Faker::Number.decimal(8, 2),
      max_participants: 30, start_date: Date.today, end_date: Date.today + 1.week,
      semester: "Spring 2019", partner_id: Faker::Number.within(1..10)
    event.save!
    EventMajor.create! event_id: event_idx + 1, major_id: Faker::Number.within(1..4)
    UserLeadEvent.create! event_id: event_idx + 1, user_id: Faker::Number.within(1..4)
    6.times do
      EventRequirement.create! event_id: event_idx + 1, deadline: Date.today + 1.week,
        requirement_id: Faker::Number.within(1..10)
    end
  end
end

4.times {|user_idx| UserEnrollEvent.create! event_id: 1, user_id: user_idx + 1}
