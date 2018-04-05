class Transaction < ApplicationRecord

  scope :expenses, -> {where(is_income: false)}

  def self.amount_spent_by_month
    self.expenses.group_by_month(:date, last: 12).sum(:amount).zeros_removed
  end

end
