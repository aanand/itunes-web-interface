class Source < OSAWrapper
  def self.get source_id
    Itunes.get.sources.find { |s| s.id2 == source_id.to_i }
  end
  
  attr_reader :playlists, :library_playlist, :jukebox_playlist
  
  def reindex
    Ramaze::Inform::info "reindexing source: #{name}"
    
    @playlists = @obj.user_playlists.collect { |p| Playlist.new(p, self) }
    
    if library?
      if @jukebox_playlist = @playlists.find { |p| p.name == jukebox_playlist_name }
        @playlists.delete(@jukebox_playlist)
      end
    end
    
    if music_playlist = @playlists.find{ |p| p.name == 'Music' }
      @library_playlist = Playlist.new(music_playlist, self)
      # @playlists.delete(music_playlist)
    else
      @library_playlist = Playlist.new(@obj.library_playlists.first, self)
    end
  end

  def jukebox_playlist_name
    'Jukebox'
  end
  
  def library?
    name == 'Library'
  end
  
  def tracks
    library_playlist.tracks
  end
end