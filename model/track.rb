class Track < OSAWrapper
  def self.get *args
    path = args.first.to_s
    
    if path.include?('/')
      get(*path.split('/'))
    else
      Playlist.get(args[0], args[1]).tracks.find { |t| t.id2 == args[2].to_i }
    end
  end
  
  cache_methods :artist, :album, :duration

  attr_reader :playlist
  
  def initialize obj, playlist
    @obj = obj
    @playlist = playlist
    reindex
  end
  
  def current?
    Itunes.get.player_state == OSA::ITunes::EPLS::PLAYING and Itunes.get.current_track.persistent_id == self.persistent_id
  end
  
  def path
    path_parts.join('/')
  end
  
  def path_parts
    begin
      [@playlist.source.id2, @playlist.id2, id2]
    rescue
      Ramaze::Inform::info self.inspect
      raise
    end
  end
  
  def time
    duration ? ("%d:%02d" % duration.divmod(60)) : ''
  end
  
  def self.get_artists tracks
    tracks.collect{ |t| t.artist }.uniq.sort
  end

  def self.get_albums tracks
    tracks.collect{ |t| t.album }.uniq.sort
  end
end