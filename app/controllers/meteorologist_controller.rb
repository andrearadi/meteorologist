require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address.gsub(" ", "+")
open(url).read
parsed_data = JSON.parse(open(url).read)
latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

url = "https://api.darksky.net/forecast/6ba487c9b3f8addcef6870298a4e0f6b/" + latitude.to_s + "," + longitude.to_s
open(url).read
parsed_data = JSON.parse(open(url).read)

current_temperature= parsed_data["currently"]["temperature"]
current_summary= parsed_data["currently"]["summary"]
sumofsixtymin= parsed_data["minutely"]["summary"]
sumofnexthours= parsed_data["hourly"]["summary"]
sumofdays= parsed_data["daily"]["summary"]

    @current_temperature = current_temperature
    @current_summary = current_summary
    @summary_of_next_sixty_minutes = sumofsixtymin
    @summary_of_next_several_hours = sumofnexthours
    @summary_of_next_several_days = sumofdays

    render("meteorologist/street_to_weather.html.erb")
  end
end
