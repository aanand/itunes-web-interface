require 'rubygems'
require 'ramaze'

# load RubyOSA
require 'rbosa'
OSA.utf8_strings = true

# require all controllers and models
acquire __DIR__/:controller/'*'
acquire __DIR__/:model/'*'

Itunes.get

require 'ramaze/contrib/gzip_filter'
Ramaze::Dispatcher::Action::FILTER << Ramaze::Filter::Gzip

Ramaze::Dispatcher::Action::FILTER << proc { |response|
  response['content-type'] = 'text/html; charset=utf-8'
  response
}

Ramaze.start :adapter => :webrick, :port => 7000
