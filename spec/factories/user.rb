FactoryBot.define do

  factory :user do
    name { "Ben Winch" }
    address { "123 Main Street" }
    city { "Denver" }
    state { "CO" }
    zip { "80014" }
    email { "benwinch@email.com" }
    password { "BWinch123" }
    password_confirmation { "BWinch123" }
  end
  
end