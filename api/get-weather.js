export default async function handler(req, res) {
  let apiKey = process.env.OPENWEATHER_API_KEY;
  let lat = req.query.lat;
  let lon = req.query.lon;

  if (!lat && !lon) {
    return res.status(400).json({error: "Please enter valid latitude and longitude parameters."})
  };

  let url = `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apiKey}`;

  try {
    let response = await fetch(url);

    if (!response.ok) {
      return res.status(response.status).json({error: "Error when getting data from OpenWeatherMap API"})
    };

    let data = await response.json();
    return res.status(200).json({weather: data})
  } catch (err) {
    return res.status(500).json({error: "An error occurred when retrieving data from the API"})
  }
}