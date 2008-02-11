class Playlist < OSAWrapper
  def self.get source_id, playlist_id
    Itunes.get.sources[source_id.to_i].playlists[playlist_id.to_i]
  end
  
  cache_methods :tracks
  
  def reindex
    puts "reindexing playlist: #{name}"
  end
end