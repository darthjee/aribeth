FactoryGirl.define do
  factory :race, class: Race do
    sequence(:code) { |n| '%04d' % n }
  end
end
