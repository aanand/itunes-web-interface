require 'rbosa'

class MainController < Ramaze::Controller
  layout '/app'

  def index
  end
  
  private

  def title
    @title || 'iTunes'
  end
end
