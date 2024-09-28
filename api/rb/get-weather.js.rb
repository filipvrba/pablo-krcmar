export default async def handler(req, res)
  api_key = process.env.OPENWEATHER_API_KEY
  lat = req.query.lat
  lon = req.query.lon

  unless lat || lon
    return res.status(400).json({
      error: 'Please enter valid latitude and longitude parameters.'
    })
  end

  url = "https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&appid=#{api_key}"

  begin
    response = await fetch(url)

    unless response.ok
      return res.status(response.status).json({
        error: 'Error when getting data from OpenWeatherMap API'
      })
    end

    data = await response.json()

    return res.status(200).json({
      weather: data
    })
  rescue => err
    return res.status(500).json({
      error: 'An error occurred when retrieving data from the API'
    })
  end
end