export default class ElmIntroduction extends HTMLElement {
  constructor() {
    super();
    this._words = Language.relevant.introduction;
    this.initElm()
  };

  connectedCallback() {
    return null
  };

  disconnectedCallback() {
    return null
  };

  initElm() {
    // <h1 class='text-center mt-5'>#{@words[0]}</h1>
    // <p class='text-center'>#{@words[1]}</p>
    let template = `${`
<div class='row'>
  <div class='col-md-6 mb-4 ps-lg-5'>
    <h1>${this._words[0]}</h1>
    <p class='lead'>${this._words[1]}</p>
  </div>
  <div class='col-md-6 text-center d-flex justify-content-center my-auto'>
    <elm-lazy-image src='/jpg/avatar_02.jpg' class='max-400' classt='max-400' style='border-radius: 50%;' alt='Pablo Krcmar'></elm-lazy-image>
  </div>
</div>

<div class='row text-center mt-5'>
  <!-- Půjčení auta -->
  <div class='col-lg-3 col-md-6 mb-3'>
    <div class='card h-100'>
      <div class='card-body'>
        <i class='bi bi-car-front-fill' style='font-size: 3rem;'></i>
        <h5 class='card-title mt-3'>${this._words[2]}</h5>
        <p class='card-text'>${this._words[3]}</p>
      </div>
    </div>
  </div>
  <!-- Ubytování -->
  <div class='col-lg-3 col-md-6 mb-3'>
    <div class='card h-100'>
      <div class='card-body'>
        <i class='bi bi-house-door-fill' style='font-size: 3rem;'></i>
        <h5 class='card-title mt-3'>${this._words[4]}</h5>
        <p class='card-text'>${this._words[5]}</p>
      </div>
    </div>
  </div>
  <!-- Rozvoz po místech -->
  <div class='col-lg-3 col-md-6 mb-3'>
    <div class='card h-100'>
      <div class='card-body'>
        <i class='bi bi-bus-front-fill' style='font-size: 3rem;'></i>
        <h5 class='card-title mt-3'>${this._words[6]}</h5>
        <p class='card-text'>${this._words[7]}</p>
      </div>
    </div>
  </div>
  <!-- Průvodce místy -->
  <div class='col-lg-3 col-md-6 mb-3'>
    <div class='card h-100'>
      <div class='card-body'>
        <i class='bi bi-map-fill' style='font-size: 3rem;'></i>
        <h5 class='card-title mt-3'>${this._words[8]}</h5>
        <p class='card-text'>${this._words[9]}</p>
      </div>
    </div>
  </div>
</div>
    `}`;
    return this.innerHTML = template
  }
}