class JukeboxController < Ramaze::Controller
  map '/jukebox'
  layout '/app'
  
  def index
    @jukebox = Itunes.get.jukebox
    @jukebox.reindex
    @tracks = @jukebox.tracks.reverse
  end
end