class AddColumnIsOutlierToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :is_outlier, :boolean, default: false
    add_index :transactions, :is_outlier
  end
end
