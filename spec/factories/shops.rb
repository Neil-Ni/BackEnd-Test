FactoryBot.define do
  factory :shop do
    name {"Shop ##{Shop.count + 1}"}
  end
end
