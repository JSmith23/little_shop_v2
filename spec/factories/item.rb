FactoryBot.define do
  factory :item do

    trait :disabled do
      enabled { false }
    end

    trait :out_of_stock do
      inventory { 0 }
    end

    sequence(:name)             { |n| "Item #{n}" }
    sequence(:description)      { |n| "Description for Item #{n}" }
    sequence(:price)            { |n| n * n }
    sequence(:inventory)        { |n| 10 * n }
    sequence(:thumbnail)        { "http://s7d2.scene7.com/is/image/JCPenney/DP0625201317031085M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2" }
  end
end
