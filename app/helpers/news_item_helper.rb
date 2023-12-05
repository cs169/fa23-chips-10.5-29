# frozen_string_literal: true

module NewsItemHelper
  def issue_options_for_select
    [
      'Free Speech',
      'Immigration',
      'Terrorism',
      'Social Security and Medicare',
      'Abortion',
      'Student Loans',
      'Gun Control',
      'Unemployment',
      'Climate Change',
      'Homelessness',
      'Racism',
      'Tax Reform',
      'Net Neutrality',
      'Religious Freedom',
      'Border Security',
      'Minimum Wage',
      'Equal Pay'
    ].map { |issue| [issue, issue] }
  end
end
