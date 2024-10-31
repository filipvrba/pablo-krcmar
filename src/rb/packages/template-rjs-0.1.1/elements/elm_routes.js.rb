export default class ElmRoutes < HTMLElement
  def initialize
    super

    @l_hashchange      = lambda { change_page() }
    @h_language_change = lambda { change_page() }

    change_page()
  end

  def connectedCallback()
    window.add_event_listener('hashchange', @l_hashchange)
    Events.connect('#app', Language::ENVS.language_change, @h_language_change)
  end

  def disconnectedCallback()
    window.remove_event_listener('hashchange', @l_hashchange)
    Events.disconnect('#app', Language::ENVS.language_change, @h_language_change)
  end

  def language_change()
    @titles = Language.relevant.titles
    @meta   = Language.relevant.meta
  end

  def change_page()
    language_change()
    
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
    #{content.sub('TITLE', @titles[page.endpoint]) if page}
    """

    self.innerHTML = template
  end

  def init_meta(page)
    title = "#{@titles[page.endpoint]} | #{@meta[0]}"

    # Title
    document.title = title
    document.query_selector('meta[property="og:title"]').set_attribute('content', @meta[0])
    document.query_selector('meta[name="twitter:title"]').set_attribute('content', @meta[0])

    # Description
    document.query_selector('meta[name="description"]').set_attribute('content', @meta[1])
    document.query_selector('meta[property="og:description"]').set_attribute('content', @meta[1])
    document.query_selector('meta[name="twitter:description"]').set_attribute('content', @meta[1])

    # Keywords
    document.query_selector('meta[name="keywords"]').set_attribute('content', @meta[2])

    # Google Analytics
    gtag("event", "search", {
      search_term: page.endpoint
    });
  end
end