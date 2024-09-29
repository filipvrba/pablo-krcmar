import contactObj from "../../json/contact.json";

export default class ElmContact extends HTMLElement {
  constructor() {
    super();
    this._words = Language.relevant.contact;
    this.initElm()
  };

  connectedCallback() {
    return null
  };

  disconnectedCallback() {
    return null
  };

  initElm() {
    let telSimple = contactObj.telephoneNumber.replaceAll(/[ -]/g, "");
    let template = `${`
<h1 class='text-center'>${this._words[0]}</h1>
<p class='text-center'>${this._words[1]}</p>

<div class='row mt-5 justify-content-center'>
  <!-- Telefonní karta -->
  <div class='col-md-4'>
    <div class='card contact-card mb-4'>
      <div class='card-body text-center'>
        <i class='bi bi-telephone-fill' style='font-size: 2rem;'></i>
        <h5 class='card-title'>${this._words[2]}</h5>
        <p class='card-text'>
          <a href='tel:${telSimple}'>${contactObj.telephoneNumber}</a>
        </p>
      </div>
    </div>
  </div>

  <!-- E-mailová karta -->
  <div class='col-md-4'>
    <div class='card contact-card mb-4'>
      <div class='card-body text-center'>
        <i class='bi bi-envelope-fill' style='font-size: 2rem;'></i>
        <h5 class='card-title'>${this._words[3]}</h5>
        <p class='card-text'>
          <a href='mailto:${contactObj.email}'>${contactObj.email}</a>
        </p>
      </div>
    </div>
  </div>
</div>
    `}`;
    return this.innerHTML = template
  }
}