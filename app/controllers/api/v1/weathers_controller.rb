module Api
  module V1
    class WeathersController < ApplicationController
      def index
        require 'json'
        require 'csv'
        url = "http://api.openweathermap.org/data/2.5/weather"
        api_key = "c265c59cd208bbda130e8dafcb70681b"
        uri = URI("#{url}?q=Tokyo,jp&APPID=#{api_key}")
        json = Net::HTTP.get(uri)
        result = JSON.parse(json)
        create_csv(result)
        render json: { status: 'OK', data: result }
      end

      private
      def create_csv(result)
        CSV.open('public/csv_files/weather_data.csv','w') do |csv|
          csv_colum_names = ["coord_lon", "coord_lat",
                              "weather_id", "weather_main", "weather_description", "weather_icon",
                              "base",
                              "main_temp", "main_feels_like", "main_temp_min", "main_temp_max", "main_pressure", "main_humidity",
                              "visibility",
                              "wind_speed", "wind_deg",
                              "clouds_all",
                              "dt",
                              "sys_type", "sys_id", "sys_country", "sys_sunrise", "sys_sunset",
                              "timezone",
                              "id",
                              "name",
                              "cod"
                              ]
          csv << csv_colum_names

          csv_colum_values = []
          csv_colum_values << result["coord"]["lon"]
          csv_colum_values << result["coord"]["lat"]
          csv_colum_values << result["weather"][0]["id"]
          csv_colum_values << result["weather"][0]["main"]
          csv_colum_values << result["weather"][0]["description"]
          csv_colum_values << result["weather"][0]["icon"]
          csv_colum_values << result["base"]
          csv_colum_values << result["main"]["temp"]
          csv_colum_values << result["main"]["feels_like"]
          csv_colum_values << result["main"]["temp_min"]
          csv_colum_values << result["main"]["temp_max"]
          csv_colum_values << result["main"]["pressure"]
          csv_colum_values << result["main"]["humidity"]
          csv_colum_values << result["visibility"]
          csv_colum_values << result["wind"]["speed"]
          csv_colum_values << result["wind"]["deg"]
          csv_colum_values << result["clouds"]["all"]
          csv_colum_values << result["dt"]
          csv_colum_values << result["sys"]["type"]
          csv_colum_values << result["sys"]["id"]
          csv_colum_values << result["sys"]["country"]
          csv_colum_values << result["sys"]["sunrise"]
          csv_colum_values << result["sys"]["sunset"]
          csv_colum_values << result["timezone"]
          csv_colum_values << result["id"]
          csv_colum_values << result["name"]
          csv_colum_values << result["cod"]
          csv << csv_colum_values
        end
      end
    end
  end
end
