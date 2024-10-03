export default class ElmFooter < HTMLElement
  def initialize
    super

    @h_language_change = lambda { init_elm() }
    
    @year  = self.get_attribute('year')
    @title = document.title.split('|').last.strip.sub(/ -.*$/, '')

    init_elm()
  end

  def connected_callback()
    Events.connect('#app', Language::ENVS.language_change, @h_language_change)
  end

  def disconnected_callback()
    Events.disconnect('#app', Language::ENVS.language_change, @h_language_change)
  end

  def language_change()
    @words = Language.relevant.footer
  end

  def init_elm()
    language_change()

    template = """
<footer class='text-center py-4'>
  <div class='container'>
    <p>&copy; #{@year} #{@title}. #{@words[0]}</p>
  </div>
  <elm-languages></elm-languages>
</footer>
    """

    self.innerHTML = template
  end
end