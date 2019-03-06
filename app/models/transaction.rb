class Transaction < ApplicationRecord

  CATEGORIES_BUDGETED_YEARLY = ['Cats', 'Home Furnishing', 'Medical Bills', 'Plane tickets', 'Special Occassion']

  scope :expenses, -> {where(is_income: false)}
  scope :budgeted_monthly, -> {where(is_budgeted_yearly: false)}
  scope :budgeted_yearly, -> {where(is_budgeted_yearly: true)}
  scope :grouped_by_last_12_months, -> {
    max_date = Transaction.maximum(:date).at_end_of_month
    min_date = (max_date - 11.months).at_beginning_of_month
    group_by_month(:date, range: (min_date..max_date))
  }

  def self.amount_spent_by_month
    [
        {name: 'All', data: self.expenses.grouped_by_last_12_months.sum(:amount).zeros_removed},
        {name: 'Budgeted Monthly', data: self.expenses.budgeted_monthly.grouped_by_last_12_months.sum(:amount).zeros_removed},
    ]
  end

  def self.update_is_budgeted_yearly_column
    self.where(category: CATEGORIES_BUDGETED_YEARLY).update_all(is_budgeted_yearly: true)
  end

end
