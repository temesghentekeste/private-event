FactoryBot.define do
  password = "password"
  factory :user do 
    name  { Faker::FunnyName.name }
    username  { Faker::Name.name}
    email  { Faker::Internet.email}
    password  { password }
    password_confirmation  { password }
  end
end