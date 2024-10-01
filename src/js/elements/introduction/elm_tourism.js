export default class ElmIntroductionTourism extends HTMLElement {
  constructor() {
    super();
    this._words = Language.relevant.introductionTourism;
    this.initElm()
  };

  connectedCallback() {
    return null
  };

  disconnectedCallback() {
    return null
  };

  initElm() {
    let template = `${`
<div class='container my-5'>
  <h2 class='text-center'>${this._words[0]}</h2>
  <p class='text-center'>${this._words[1]}</p>

  <div class='row text-center mt-5'>
      <!-- Pláž -->
      <div class='col-md-4 mb-3'>
          <div class='card'>
              <img src='/jpg/plaz_01.jpg' class='card-img-top' loading='lazy' alt='Beach'>
              <div class='card-body'>
                  <h5 class='card-title'>${this._words[2]}</h5>
                  <p class='card-text'>${this._words[3]}</p>
              </div>
          </div>
      </div>
      <!-- Jezero -->
      <div class='col-md-4 mb-3'>
          <div class='card'>
              <img src='/jpg/jezero_01.jpg' class='card-img-top' loading='lazy' alt='Lake'>
              <div class='card-body'>
                  <h5 class='card-title'>${this._words[4]}</h5>
                  <p class='card-text'>${this._words[5]}</p>
              </div>
          </div>
      </div>
      <!-- Moře a výhledy -->
      <div class='col-md-4 mb-3'>
          <div class='card'>
              <img src='/jpg/vyhled_01.jpg' class='card-img-top' loading='lazy' alt='Sea'>
              <div class='card-body'>
                  <h5 class='card-title'>${this._words[6]}</h5>
                  <p class='card-text'>${this._words[7]}</p>
              </div>
          </div>
      </div>
  </div>
</div>
    `}`;
    return this.innerHTML = template
  }
}