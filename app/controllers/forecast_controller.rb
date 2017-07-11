require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

url = "https://api.darksky.net/forecast/6ba487c9b3f8addcef6870298a4e0f6b/" + @lat + "," + @lng
open(url).read
parsed_data = JSON.parse(open(url).read)

 current_temperaturetemp= parsed_data["currently"]["temperature"]
 current_summary= parsed_data["currently"]["summary"]
 sumofsixtymin= parsed_data["minutely"]["summary"]
 sumofnexthours= parsed_data["hourly"]["summary"]
 sumofdays= parsed_data["daily"]["summary"]
 
    @current_temperature = current_temperaturetemp

    @current_summary = current_summary

    @summary_of_next_sixty_minutes = sumofsixtymin

    @summary_of_next_several_hours = sumofnexthours

    @summary_of_next_several_days = sumofdays

    render("forecast/coords_to_weather.html.erb")
  end
end
