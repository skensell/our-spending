module WelcomeHelper

  def to_dollars(number, opts=nil)
    opts ||= {}
    opts = {precision: 0}.merge(opts)
    number_to_currency(number, opts)
  end

end
