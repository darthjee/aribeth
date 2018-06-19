FactoryBot.define do
  factory :race, class: Race do
    sequence(:code) { |n| '%04d' % n }
    playable true
  end
end
