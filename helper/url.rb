# frozen_string_literal: true

require 'sinatra'

def base_url
  @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
end
