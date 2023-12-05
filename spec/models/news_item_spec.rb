# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  it 'validates presence of issue' do
    news_item = described_class.new(title: 'Sample Title', link: 'http://example.com', description: 'Sample description')
    expect(news_item.valid?).to be false
    expect(news_item.errors[:issue]).to include("can't be blank")
  end

  it 'validates inclusion of issue in allowed list' do
    news_item = described_class.new(title: 'Sample Title', link: 'http://example.com', description: 'Sample description',
                                    issue: 'Invalid Issue')
    expect(news_item.valid?).to be false
    expect(news_item.errors[:issue]).to include('is not included in the list')
  end
end
