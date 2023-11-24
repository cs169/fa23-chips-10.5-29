# frozen_string_literal: true

# spec/factories/news_items.rb
FactoryBot.define do
  factory :news_item do
    title { 'hello' }
    count { 0 }
    id { 1 }
    description { 'greetings' }
    link { 'www.google.com' }
    representative_id { 123 }
    created_at { '2001-02-03T04:05:06+03:00' }
    updated_at { '2010-02-03T04:05:06+03:00' }
    representative
  end
end
