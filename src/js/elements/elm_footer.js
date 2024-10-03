export default class ElmFooter extends HTMLElement {
  constructor() {
    super();

    this._hLanguageChange = () => {
      return this.initElm()
    };

    this._year = this.getAttribute("year");

    this._title = document.title.split("|")[document.title.split("|").length - 1].trim().replace(
      / -.*$/m,
      ""
    );

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
    this._words = Language.relevant.footer;
    return this._words
  };

  initElm() {
    this.languageChange();
    let template = `${`
<footer class='text-center py-4'>
  <div class='container'>
    <p>&copy; ${this._year} ${this._title}. ${this._words[0]}</p>
  </div>
  <elm-languages></elm-languages>
</footer>
    `}`;
    return this.innerHTML = template
  }
}