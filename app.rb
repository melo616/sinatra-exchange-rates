require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  url = "https://api.exchangerate.host/symbols"
  api_data = HTTP.get(url)
  parsed_data = JSON.parse(api_data)
  @symbols_hash = parsed_data.fetch("symbols")
  erb(:homepage)
end

get("/:curr_sym") do
  @sym = params.fetch("curr_sym")
  url = "https://api.exchangerate.host/symbols"
  api_data = HTTP.get(url)
  parsed_data = JSON.parse(api_data)
  @symbols_hash = parsed_data.fetch("symbols")
  erb(:curr_landing)
end

get("/:curr_from/:curr_to") do
  @curr_from = params.fetch("curr_from")
  @curr_to = params.fetch("curr_to")
  url = "https://api.exchangerate.host/convert?from=" + @curr_from + "&to=" + @curr_to
  pp "URL"
  pp url
  api_data = HTTP.get(url)
  parsed_data = JSON.parse(api_data)
  pp "PARSED DATA"
  pp parsed_data.fetch("result")
  @result = parsed_data.fetch("result")
  erb(:convert_page)
end
