export default class ElmLanguages extends HTMLElement {
  constructor() {
    super();

    this._hLanguageChange = () => {
      return this.initElm()
    };

    this._words = Language.relevant.languages;
    this.initElm()
  };

  connectedCallback() {
    return Events.connect(
      "#app",
      Language.ENVS.languageChange,
      this._hLanguageChange
    )
  };

  disconnectedCallback() {
    return Events.disconnect(
      "#app",
      Language.ENVS.languageChange,
      this._hLanguageChange
    )
  };

  languageChange() {
    this._words = Language.relevant.languages;
    return this._words
  };

  initElm() {
    this.languageChange();
    let template = `${`
<div class='footer-lang-switcher' style=''>
  <p>${this._words[0]}<br>${this._words[1]}</p>
  <ul class='list-inline'>
    <li class='list-inline-item pb-3'>
      <button class='btn btn-light' onclick='Language.set("cs")'>Čeština</button>
    </li>
    <li class='list-inline-item pb-3'>
      <button class='btn btn-light' onclick='Language.set("en")'>English</button>
    </li>
    <li class='list-inline-item pb-3'>
      <button class='btn btn-light' onclick='Language.set("es")'>Español</button>
    </li>
  </ul>
</div>
    `}`;
    return this.innerHTML = template
  }
}