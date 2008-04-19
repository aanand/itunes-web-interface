module Ramaze
  module HighlightHelper
    def highlighted_link text, url
      opts = {:href => url}
      opts[:class] = 'selected' if request.path_info == url
      
      A(text, opts)
    end
  end
end
