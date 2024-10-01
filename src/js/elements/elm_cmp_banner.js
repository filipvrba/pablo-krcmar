export default class ElmCmpBanner extends HTMLElement {
  constructor() {
    super();

    this._hAcceptCookiesClick = () => {
      return this.acceptAllCookies()
    };

    this._hRejectCookiesClick = () => {
      return this.rejectAllCookies()
    };

    this._words = Language.relevant.cmpBanner;
    this.initElm();
    this._cmpBanner = this.querySelector("#cmp-banner");
    this._acceptCookies = this.querySelector("#accept-cookies");
    this._rejectCookies = this.querySelector("#reject-cookies")
  };

  connectedCallback() {
    this._acceptCookies.addEventListener(
      "click",
      this._hAcceptCookiesClick
    );

    this._rejectCookies.addEventListener(
      "click",
      this._hRejectCookiesClick
    );

    return this.showBanner()
  };

  disconnectedCallback() {
    this._acceptCookies.removeEventListener(
      "click",
      this._hAcceptCookiesClick
    );

    return this._rejectCookies.removeEventListener(
      "click",
      this._hRejectCookiesClick
    )
  };

  showBanner() {
    if (!localStorage.getItem("userConsent")) {
      this._cmpBanner.classList.remove("d-none");
      return setTimeout(() => this._cmpBanner.classList.add("show"), 500)
    }
  };

  hideBanner() {
    this._cmpBanner.classList.remove("show");
    return setTimeout(() => this._cmpBanner.classList.add("d-none"), 500)
  };

  acceptAllCookies() {
    localStorage.setItem("userConsent", "all");
    this.manageCookies(true);
    return this.hideBanner()
  };

  rejectAllCookies() {
    localStorage.setItem("userConsent", "none");
    this.manageCookies(false);
    return this.hideBanner()
  };

  manageCookies(allowCookies) {
    return allowCookies ? gtag(
      "consent",
      "update",
      {adStorage: "granted", analyticsStorage: "granted"}
    ) : gtag(
      "consent",
      "update",
      {adStorage: "denied", analyticsStorage: "denied"}
    )
  };

  initElm() {
    let template = `${`
<div id='cmp-banner' class='d-none'>
  <div class='container'>
    <h5>${this._words[0]}</h5>
    <p>${this._words[1]}</p>
    <div class='cmp-options'>
      <button class='btn btn-success btn-sm' id='accept-cookies'>${this._words[2]}</button>
      <button class='btn btn-danger btn-sm' id='reject-cookies'>${this._words[3]}</button>
    </div>
  </div>
</div>
    `}`;
    return this.innerHTML = template
  }
}