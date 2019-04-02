File.open("app/uploaders/avatar.jpg") do |file|
  User.types.keys.each_with_index do |type, index|
    name = index.zero? ? "Administrator" : type
    code = ('A'..'Z').to_a.shuffle[0, 2].join << (0..9).to_a.shuffle[0, 8].join
    user = User.new
    user.build_avatar.file = file
    user.update_attributes name: name, email: "#{type.downcase}@fpt.edu.vn",
      type: type, password: "123456", gender: (0..1).to_a.shuffle[0],
      code: code, phone: (0..9).to_a.shuffle[0, 10].join, dob: Date.today,
      confirmed_at: Date.today
    user.save!
  end
end

Major.create! name: "English", acronym: "EN"
Major.create! name: "Japanse", acronym: "JP"
Major.create! name: "Software Engineering", acronym: "SE"
Major.create! name: "Business", acronym: "SB"

Requirement.create! name: "Visa"
Requirement.create! name: "Passport"
Requirement.create! name: "IELTS"
Requirement.create! name: "TOEFL"
Requirement.create! name: "Identity Card"
