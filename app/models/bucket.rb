class Bucket < ApplicationRecord
  INCOME_ID = 7

  scope :expenses, -> { where.not(id: INCOME_ID) }

  has_many :categories
end
