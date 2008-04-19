require 'rbosa'

class MainController < Ramaze::Controller
  layout '/app'

  def index
    redirect R(JukeboxController)
  end
end
