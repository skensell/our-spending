module WelcomeHelper

  def to_dollars(number, opts=nil)
    opts ||= {}
    opts = {precision: 0}.merge(opts)
    number_to_currency(number, opts)
  end

  def month_name(month_number)
    months_enumerated.find { |name, index| index == month_number }.first
  end

  def months_enumerated
    [['January', 1], ['February', 2], ['March', 3], ['April', 4], ['May', 5], ['June', 6],
     ['July', 7], ['August', 8], ['September', 9], ['October', 10], ['November', 11], ['December', 12]]
  end

end
