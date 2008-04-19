class SourceController < Ramaze::Controller
  map '/source'
  layout '/app'

  deny_layout :filter
  
  def list source_id
    @tracks = Source.get(source_id).library_playlist.tracks
  end
  
  def filter
    @tracks = Source.get(request[:source_id]).library_playlist.filter(request)
  end
end