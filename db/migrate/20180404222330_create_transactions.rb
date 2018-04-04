class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.date :date
      t.text :category
      t.integer :amount
      t.text :note
      t.boolean :is_income, default: false

      t.timestamps
    end
  end
end
