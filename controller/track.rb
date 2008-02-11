class TrackController < Ramaze::Controller
  map '/track'
  layout '/app'
  
  def play source_id, playlist_id, track_id
    Track.get(source_id, playlist_id, track_id).play
    redirect_referer
  end
end