FactoryBot.define do
  factory :book do
    title {"Book ##{Book.count + 1}"}
    publisher_id {1}
  end
end
