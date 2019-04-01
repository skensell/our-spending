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
    self.expenses.between(p.min_date, p.max_date).where(category: Category.where(id: p.category_ids).pluck(:name))
  end

  def self.line_graph_data_from_search_params(p)
    data = self.from_search_params(p).group_by_month(:date).sum(:amount)
    if data.length == 1
      # only one month requested, show cumulative transaction sum
      amounts_by_day = self.from_search_params(p).group_by_day(:date).sum(:amount)
      cumulative_amounts = {}
      sum = 0
      for (k, v) in amounts_by_day do
        sum += v
        cumulative_amounts[k] = sum
      end
      data = cumulative_amounts
    end
    return [
        {name: 'All Expenses', data: data}
    ]
  end

  def self.update_is_budgeted_yearly_column
    self.where(category: CATEGORIES_BUDGETED_YEARLY).update_all(is_budgeted_yearly: true)
  end

end
