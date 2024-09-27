export default class ElmFooter extends HTMLElement {
  constructor() {
    super();
    this._year = this.getAttribute("year");

    this._title = document.title.split("|")[document.title.split("|").length - 1].trim().replace(
      / -.*$/m,
      ""
    );

    this._words = Language.relevant.footer;
    this.initElm()
  };

  initElm() {
    let template = `${`
    <footer class='text-center py-4'>
      <div class='container'>
        <p>&copy; ${this._year} ${this._title}. ${this._words[0]}</p>
      </div>
    </footer>
    `}`;
    return this.innerHTML = template
  }
}