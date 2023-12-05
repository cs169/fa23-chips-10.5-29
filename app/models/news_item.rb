# frozen_string_literal: true

class NewsItem < ApplicationRecord
  belongs_to :representative
  has_many :ratings, dependent: :delete_all

  validates :issue, presence: true, inclusion: { in: [
    'Free Speech', 'Immigration', 'Terrorism', 'Social Security and Medicare',
    'Abortion', 'Student Loans', 'Gun Control', 'Unemployment',
    'Climate Change', 'Homelessness', 'Racism', 'Tax Reform',
    'Net Neutrality', 'Religious Freedom', 'Border Security',
    'Minimum Wage', 'Equal Pay'
  ] }

  # ... rest of your model code ...
end
