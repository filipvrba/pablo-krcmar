export default class ElmHeader extends HTMLElement {
  constructor() {
    super();
    this._title = document.title.split("|")[document.title.split("|").length - 1].trim();
    this.initElm();
    window.headerHide = this.hide.bind(this)
  };

  hide() {
    return Events.emit("#navbarSupportedContent", "collapse.hide")
  };

  initElm() {
    let template = `${`
<nav class='navbar navbar-expand-lg'>
  <div class='container'>
    <a class='navbar-brand' href='#' onclick='headerHide()'>
      <!-- <img src='/png/logo_pivnice-256x256.png' alt='${this._title}' style='height: 64px;'> -->
      ${this._title}
    </a>
    <button class='navbar-toggler' type='button' data-bs-toggle='collapse' data-bs-target='#navbarSupportedContent' aria-controls='navbarSupportedContent' aria-expanded='false' aria-label='Toggle navigation'>
      <span class='navbar-toggler-icon'></span>
    </button>

    <div class='collapse navbar-collapse' id='navbarSupportedContent'>
      <ul class='navbar-nav ml-auto'>
        ${this.menuListInitElm()}
      </ul>
    </div>
  </div>
</nav>
    `}`;
    return this.innerHTML = template
  };

  menuListInitElm() {
    let elements = [];
    let pages = Routes.priorityPages(1);

    for (let page of pages) {
      let title = Language.relevant.titles[page.endpoint];
      let template = `${`
      <li class='nav-item'>
        <a class='nav-link' href='#${page.endpoint}' onclick='headerHide()'>${title}</a>
      </li>
      `}`;
      elements.push(template)
    };

    return elements.join("")
  }
}