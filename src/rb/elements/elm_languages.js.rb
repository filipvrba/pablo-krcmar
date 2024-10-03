export default class ElmLanguages < HTMLElement
  def initialize
    super

    @h_language_change = lambda { init_elm() }

    @words = Language.relevant.languages
    
    init_elm()
  end

  def connected_callback()
    Events.connect('#app', Language::ENVS.language_change, @h_language_change)
  end

  def disconnected_callback()
    Events.disconnect('#app', Language::ENVS.language_change, @h_language_change)
  end

  def language_change()
    @words = Language.relevant.languages
  end

  def init_elm()
    language_change()

    template = """
<div class='footer-lang-switcher' style=''>
  <p>#{@words[0]}<br>#{@words[1]}</p>
  <ul class='list-inline'>
    <li class='list-inline-item pb-3'>
      <button class='btn btn-light' onclick='Language.set(\"cs\")'>Čeština</button>
    </li>
    <li class='list-inline-item pb-3'>
      <button class='btn btn-light' onclick='Language.set(\"en\")'>English</button>
    </li>
    <li class='list-inline-item pb-3'>
      <button class='btn btn-light' onclick='Language.set(\"es\")'>Español</button>
    </li>
  </ul>
</div>
    """

    self.innerHTML = template
  end
end