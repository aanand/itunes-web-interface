class Playlist < OSAWrapper
  def self.get source_id, playlist_id
    Source.get(source_id).playlists.find { |p| p.id2 == playlist_id.to_i }
  end
  
  attr_reader :tracks, :source
  
  def initialize obj, source
    @obj = obj
    @source = source
    reindex
  end
  
  def reindex
    Ramaze::Inform::info "reindexing playlist: #{name}"
    
    @tracks = @obj.tracks.collect { |t| Track.new(t, self) }
  end
  
  def << *args
    args.flatten.each do |track|
      track.duplicate(@obj)
    end
    
    reindex
  end
  
  def filter filters
    tracks = @tracks
    
    [:artist, :album].each do |field|
      unless filters[field].to_s.empty?
        tracks = tracks.select { |t|
          t.send(field).downcase == filters[field].downcase
        }
      end
    end
    
    tracks
  end
end