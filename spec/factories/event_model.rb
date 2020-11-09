FactoryBot.define do
  factory :event do
    title { Faker::Lorem.sentence(word_count: 2)  }
    description { Faker::Lorem.sentence(word_count: 3)  }
    start_datetime { Date.today }
    end_datetime { Date.today + 4.weeks }
    creator { User.first }
  end
end