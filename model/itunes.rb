require 'rbosa'

class Itunes < OSAWrapper
  def self.get
    @itunes ||= self.new(OSA.app('iTunes'))
  end
  
  attr_reader :sources
  
  def reindex
    @sources = {}
    
    @obj.sources.each do |s|
      @sources[s.id2] = Source.new(s)
    end
  end
end