export default class ElmRoutes < HTMLElement
  def initialize
    super

    @l_hashchange = lambda { change_page() }
    @title_app = document.title

    change_page()
  end

  def connectedCallback()
    window.add_event_listener('hashchange', @l_hashchange)
  end

  def disconnectedCallback()
    window.remove_event_listener('hashchange', @l_hashchange)
  end

  def change_page()
    current_page = find_current_page()
    init_page(current_page) if current_page
  end

  def find_current_page()
    ROUTES_JSON.pages.each do |page|
      unless page.endpoint == location.hash.sub('#', '')
        next
      end

      return page
    end

    return nil
  end

  def init_page(page)
    init_meta(page)
    
    page_name = page.endpoint
    content = PAGES[page_name]
    init_elm(content, page)
  end

  def init_elm(content, page = nil)
    template = """
    #{content.sub('TITLE', page.title) if page}
    """

    self.innerHTML = template
  end

  def init_meta(page)
    title = "#{page.title} | #{@title_app}"

    # Title
    document.title = title
  end
end