export default class ElmWeatherRadar extends HTMLElement {
  constructor() {
    super();
    this._lat = this.getAttribute("lat");
    this._lon = this.getAttribute("lon");
    this._words = Language.relevant.weatherRadar;
    this.initElm();
    this._cityName = this.querySelector("#cityName");
    this._weatherIcon = this.querySelector("#weatherIcon");
    this._temperature = this.querySelector("#temperature");
    this._feelsLike = this.querySelector("#feelsLike");
    this._humidity = this.querySelector("#humidity");
    this._wind = this.querySelector("#wind")
  };

  connectedCallback() {
    return Net.curl(
      `/api/get-weather?lat=${this._lat}&lon=${this._lon}`,

      (content) => {
        let weatherObj = JSON.parse(content).weather;
        return this.subinitElm(weatherObj)
      }
    )
  };

  disconnectedCallback() {
    return null
  };

  initElm() {
    let template = `${`
<div class='container my-5'>
  <h2 class='text-center'>${this._words[0]}</h2>

  <div class='row text-center mt-3'>
    <div class='col-md-6 mb-3 mx-auto'>
      <div class='card bg-light shadow'>
        <div class='card-body'>
          <h3 id='cityName' class='card-title'>Valencia</h3>
          <img id='weatherIcon' class='' src='' alt='Weather' />
          <p class='card-text'><strong>${this._words[1]}:</strong> <span id='temperature'></span></p>
          <p class='card-text'><strong>${this._words[2]}:</strong> <span id='feelsLike'></span></p>
          <p class='card-text'><strong>${this._words[3]}:</strong> <span id='humidity'></span></p>
          <p class='card-text'><strong>${this._words[4]}:</strong> <span id='wind'></span></p>
        </div>
      </div>
    </div>
  </div>
</div>
    `}`;
    return this.innerHTML = template
  };

  subinitElm(weatherObj) {
    this._cityName.innerText = weatherObj.name;
    let tempInCelsius = this.kelvinToCelsius(weatherObj.main.temp);
    this._temperature.innerText = `${tempInCelsius} °C`;
    let feelsInCelsius = this.kelvinToCelsius(weatherObj.main.feels_like);
    this._feelsLike.innerText = `${feelsInCelsius} °C`;
    this._humidity.innerText = `${weatherObj.main.humidity}%`;
    this._wind.innerText = `${weatherObj.wind.speed} m/s`;
    let iconCode = weatherObj.weather[0].icon;
    return this._weatherIcon.src = `https://openweathermap.org/img/wn/${iconCode}@2x.png`
  };

  kelvinToCelsius(temperature) {
    return (temperature - 273.15).toFixed(2)
  }
}