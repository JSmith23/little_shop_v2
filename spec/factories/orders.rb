FactoryBot.define do

  factory :order do

    status= [ 'Pending', 'Fulfilled', 'Canceled']

    sequence(:status) { "#{status.sample}" }

  end

end
