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
  Partner.create! name: Faker::University.unique.name, country: Faker::Nation.nationality,
    address: Faker::Address.full_address
  Requirement.create! name: Faker::Food.unique.dish
end
