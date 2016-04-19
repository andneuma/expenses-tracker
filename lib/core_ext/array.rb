class Array
  def which_elements_not_in(array)
    if array.empty?
      self
    else
      self.select {|e| !array.include?(e)}
    end
  end
end
