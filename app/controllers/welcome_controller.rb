class WelcomeController < ApplicationController

  def index

    # parse search params
    @search_params = TransactionSearchParams.new(get_search_params)

    @transactions = Transaction.from_search_params(@search_params)
    @amounts_by_month = @transactions.group_by_month(:date).sum(:amount)
    @total_months = @amounts_by_month.count
    @line_chart_data = Transaction.data_for_monthly_line_graph(@search_params)
  end

  private

  def get_search_params
    p = params[:transaction_search_params]
    return default_search_params if !p
    {
        start_month: p[:start_month].to_i,
        start_year: p[:start_year].to_i,
        end_month: p[:end_month].to_i,
        end_year: p[:end_year].to_i,
        category_ids: (p[:category_ids] || []).map(&:to_i)
    }
  end

  def default_search_params
    end_date = Transaction.maximum(:date)
    start_date = end_date - 11.months
    {
        start_month: start_date.month,
        start_year: start_date.year,
        end_month: end_date.month,
        end_year: end_date.year,
        category_ids: Category.expenses.pluck(:id)
    }
  end

end
