class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :bucket, foreign_key: true
      t.boolean :is_income, default: false
      t.float :budget

      t.timestamps
    end
  end
end
