class AddColumnIsBudgetedYearlyToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :is_budgeted_yearly, :boolean, default: false
  end
end
