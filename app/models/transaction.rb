class Transaction < ApplicationRecord

  CATEGORIES_BUDGETED_YEARLY = ['Cats', 'Home Furnishing', 'Medical Bills', 'Plane tickets', 'Special Occasion']

  scope :expenses, -> {where(is_income: false)}
  scope :budgeted_monthly, -> {where(is_budgeted_yearly: false)}
  scope :budgeted_yearly, -> {where(is_budgeted_yearly: true)}
  scope :grouped_by_last_12_months, -> {group_by_month(:date, last: 12)}

  def self.amount_spent_by_month
    [
        {name: 'All Categories', data: self.expenses.grouped_by_last_12_months.sum(:amount).zeros_removed},
        {name: 'Monthly Categories', data: self.expenses.budgeted_monthly.grouped_by_last_12_months.sum(:amount).zeros_removed},
    ]
  end

  def self.update_is_budgeted_yearly_column
    self.where(category: CATEGORIES_BUDGETED_YEARLY).update_all(is_budgeted_yearly: true)
  end

end
