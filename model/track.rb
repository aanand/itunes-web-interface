class Track < OSAWrapper
  def self.get source_id, playlist_id, track_id
    Itunes.get.sources[source_id.to_i].playlists[playlist_id.to_i].tracks.select { |t| t.id2 == track_id.to_i }
  end
  
  cache_methods :artist, :album, :track_number
  
  def initialize obj
    @obj = obj
    reindex
  end
  
  def sort_key
    [artist, album, track_number, name]
  end
end