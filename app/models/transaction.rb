class Transaction < ApplicationRecord

  CATEGORIES_BUDGETED_YEARLY = ['Cats', 'Home Furnishing', 'Medical Bills', 'Plane tickets', 'Special Occassion']

  scope :expenses, -> {where(is_income: false)}
  scope :budgeted_monthly, -> {where(is_budgeted_yearly: false)}
  scope :budgeted_yearly, -> {where(is_budgeted_yearly: true)}
  scope :between, lambda {|start_date, end_date| where("date IS NOT NULL AND date >= ? AND date <= ?", start_date, end_date)}
  scope :grouped_by_last_12_months, -> {
    max_date = Transaction.maximum(:date).at_end_of_month
    min_date = (max_date - 11.months).at_beginning_of_month
    group_by_month(:date, range: (min_date..max_date))
  }

  def self.from_search_params(p)
    self.expenses.between(p.min_date, p.max_date)
  end

  def self.data_for_monthly_line_graph(p)
    [
        {name: 'All', data: self.from_search_params(p).group_by_month(:date).sum(:amount).zeros_removed},
        {name: 'Budgeted Monthly', data: self.from_search_params(p).budgeted_monthly.group_by_month(:date).sum(:amount).zeros_removed},
    ]
  end

  def self.update_is_budgeted_yearly_column
    self.where(category: CATEGORIES_BUDGETED_YEARLY).update_all(is_budgeted_yearly: true)
  end

end
