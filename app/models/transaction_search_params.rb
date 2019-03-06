class TransactionSearchParams
  include ActiveModel::Model
  attr_accessor :start_month, :start_year,
                :end_month, :end_year

  attr_reader :min_date, :max_date

  def initialize(attributes={})
    super
    # add derived properties here if necessary
    @min_date = Date.new(attributes[:start_year].to_i, attributes[:start_month].to_i).at_beginning_of_month
    @max_date = Date.new(attributes[:end_year].to_i, attributes[:end_month].to_i).at_end_of_month
  end

end