class PlaylistController < Ramaze::Controller
  map '/playlist'
  layout '/app'
  
  def list source_id, playlist_id
    @source = Source.get(source_id)
    @playlist = Playlist.get(source_id, playlist_id)
  end
end