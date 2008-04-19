class PlaylistController < Ramaze::Controller
  map '/playlist'
  layout '/app'
  
  def list source_id, playlist_id
    @tracks = Playlist.get(source_id, playlist_id).tracks
  end
end