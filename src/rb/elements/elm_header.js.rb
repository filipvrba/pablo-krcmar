export default class ElmHeader < HTMLElement
  def initialize
    super

    @h_language_change = lambda { init_elm() }
    
    @title = document.title.split('|').last.strip.sub(/ -.*$/, '')

    init_elm()

    window.header_hide = hide
  end

  def connected_callback()
    Events.connect('#app', Language::ENVS.language_change, @h_language_change)
  end

  def disconnected_callback()
    Events.disconnect('#app', Language::ENVS.language_change, @h_language_change)
  end

  def language_change()
    @words = Language.relevant.titles
  end

  def hide()
    Events.emit('#navbarSupportedContent', 'collapse.hide')
  end

  def init_elm()
    language_change()

    template = """
<nav class='navbar navbar-expand-lg'>
  <div class='container'>
    <a class='navbar-brand' href='#' onclick='headerHide()'>
      <img src='/png/spain.png' alt='#{@title}' style='height: 64px;'>
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
      title    = @words[page.endpoint]
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