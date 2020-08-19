Publisher.delete_all
Shop.delete_all
Book.delete_all

10.times do
  Publisher.create(name: Faker::App.name)
end

10.times do
  Shop.create(name: "#{Faker::Company.name} #{Faker::Company.industry}")
end

Publisher.all.each do |publisher|
  10.times do
    book = publisher.books.create(title: Faker::Hipster.sentence(word_count: 3))
    20.times do
      shop = Shop.find(Shop.pluck(:id).sample(1)[0])
      shop.books << book
      shop.sell(book.id) if rand(2) % 2 == 0
    end
  end
end