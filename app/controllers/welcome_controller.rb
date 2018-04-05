class WelcomeController < ApplicationController

  def index
    months = Transaction.expenses.grouped_by_last_12_months.sum(:amount).zeros_removed
    @months_involved = months.keys
    @total_months = months.count
  end

end
