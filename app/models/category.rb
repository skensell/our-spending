class Category < ApplicationRecord

  scope :expenses, -> { where(is_income: false) }

  belongs_to :bucket
end
