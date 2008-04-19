class Itunes < OSAWrapper
  def self.get
    @itunes ||= self.new(OSA.app('iTunes'))
  end
  
  attr_reader :sources, :library, :jukebox
  
  def reindex
    @sources = @obj.sources.select{ |s| s.name != 'Radio' }.collect{ |s| Source.new(s) }
    @library = @sources.find { |s| s.library? }
    @jukebox = @library.jukebox_playlist
  end
  
  def play_now tracks
    index = @jukebox.tracks.length
    @jukebox << tracks
    @jukebox.tracks[index].play
  end
end