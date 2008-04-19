class TrackController < Ramaze::Controller
  map '/track'
  
  def queue *parts
    Itunes.get.jukebox << get_tracks(*parts)
    respond ' '
  end
  
  def play *parts
    Itunes.get.play_now(get_tracks(*parts))
    respond ' '
  end
  
  private
  
  def get_tracks *args
    if request.post?
      request.body.readlines.map { |path| Track.get(path) }
    else
      [Track.get(*args)]
    end
  end
end