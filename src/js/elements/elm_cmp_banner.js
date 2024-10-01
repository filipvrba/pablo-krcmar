export default class ElmCmpBanner extends HTMLElement {
  constructor() {
    super();

    this._hAcceptCookiesClick = () => {
      return this.acceptAllCookies()
    };

    this._hRejectCookiesClick = () => {
      return this.rejectAllCookies()
    };

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
      return this._cmpBanner.classList.remove("d-none")
    }
  };

  hideBanner() {
    return this._cmpBanner.classList.add("d-none")
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
    <h5>Vaše soukromí je pro nás důležité</h5>
    <p>
      Tento web používá cookies k ukládání údajů o vaší návštěvě a klikání na rubriky pro zlepšení našich služeb.
      Souhlasíte s tímto sledováním? Více informací naleznete v <a href='/privacy-policy' target='_blank' style='color: #17a2b8;'>zásadách ochrany osobních údajů</a>.
    </p>
    <div class='cmp-options'>
      <button class='btn btn-success btn-sm' id='accept-cookies'>Přijmout vše</button>
      <button class='btn btn-danger btn-sm' id='reject-cookies'>Odmítnout vše</button>
      <button class='btn btn-secondary btn-sm' id='customize-cookies'>Nastavit</button>
    </div>
  </div>
</div>
    `}`;
    return this.innerHTML = template
  }
}