class Array
  def / n
    as = []
    i = 0
    
    while i < length
      as << self[i..i+n-1]
      i += n
    end
    
    as
  end
end