require 'open-uri'
require 'json'

class ForecastsController < ApplicationController
  def location

the_address = params[:address]

# Address to Coords
url_safe_address = URI.encode(the_address)

url_of_data_we_want = "http://maps.googleapis.com/maps/api/geocode/json?address="
url = url_of_data_we_want + url_safe_address
raw_data = open(url).read
parsed_data = JSON.parse(raw_data)
the_latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
the_longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

# Coords to Weather
url_of_weather_we_want = "https://api.forecast.io/forecast/a432dda20e513555718f2527e386944c/#{the_latitude},#{the_longitude}"
raw_weather = open(url_of_weather_we_want).read
parsed_weather = JSON.parse(raw_weather)
the_temperature = parsed_weather["currently"]["temperature"]
the_hour_outlook = parsed_weather["hourly"]["data"][1]["summary"]
the_day_outlook = parsed_weather["daily"]["data"][1]["summary"]

@address = the_address
@temperature = the_temperature
@hourly = the_hour_outlook
@day = the_day_outlook

  end
end
