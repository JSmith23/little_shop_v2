FactoryBot.define do
  factory :order do
    status      { "pending" }
    active      { true }
  end
end
