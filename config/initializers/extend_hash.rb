class Hash
  # We extend the class with some helper functionality
  def zeros_removed
    self.select {|k,v| v > 0}
  end
end