class Ramaze::Controller
  helper :highlight, :partial, :inform

  private
  
  def title
    @title || 'iTunes'
  end
end