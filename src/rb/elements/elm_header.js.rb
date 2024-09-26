export default class ElmHeader < HTMLElement
  def initialize
    super
    
    @title = document.title.split('|').last.strip

    init_elm()

    window.header_hide = hide
  end

  def hide()
    Events.emit('#navbarSupportedContent', 'collapse.hide')
  end

  def init_elm()
    template = """
<nav class='navbar navbar-expand-lg'>
  <div class='container'>
    <a class='navbar-brand' href='#' onclick='headerHide()'>
      <!-- <img src='/png/logo_pivnice-256x256.png' alt='#{@title}' style='height: 64px;'> -->
      #{@title}
    </a>
    <button class='navbar-toggler' type='button' data-bs-toggle='collapse' data-bs-target='#navbarSupportedContent' aria-controls='navbarSupportedContent' aria-expanded='false' aria-label='Toggle navigation'>
      <span class='navbar-toggler-icon'></span>
    </button>

    <div class='collapse navbar-collapse' id='navbarSupportedContent'>
      <ul class='navbar-nav ml-auto'>
        #{menu_list_init_elm()}
      </ul>
    </div>
  </div>
</nav>
    """

    self.innerHTML = template
  end

  def menu_list_init_elm()
    elements = []
    pages    = Routes.priority_pages(1)

    pages.each do |page|
      title    = Language.relevant.titles[page.endpoint] 
      template = """
      <li class='nav-item'>
        <a class='nav-link' href='##{page.endpoint}' onclick='headerHide()'>#{title}</a>
      </li>
      """

      elements.push(template)
    end

    return elements.join('')
  end
end