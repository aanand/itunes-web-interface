class SourceController < Ramaze::Controller
  map '/source'
  layout '/app'
  
  def list source_id
    @source = Source.get(source_id)
    @playlist = @source.main_playlist
  end
end