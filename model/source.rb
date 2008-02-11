class Source < OSAWrapper
  def self.get id
    Itunes.get.sources[id.to_i]
  end
  
  attr_reader :playlists, :main_playlist
  
  def reindex
    puts "reindexing source: #{name}"
    
    @playlists = {}
    
    @obj.playlists.each do |p|
      @playlists[p.id2] = Playlist.new(p)
    end
    
    @main_playlist = @playlists.values.find { |p| p.name == self.name }
  end
  
  def tracks
    main_playlist.tracks
  end
end