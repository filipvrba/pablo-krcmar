export default class ElmFooter < HTMLElement
  def initialize
    super
    
    @year  = self.get_attribute('year')
    @title = document.title.split('|').last.strip
    @words = Language.relevant.footer

    init_elm()
  end

  def init_elm()
    template = """
    <footer class='text-center py-4'>
      <div class='container'>
        <p>&copy; #{@year} #{@title}. #{@words[0]}</p>
      </div>
    </footer>
    """

    self.innerHTML = template
  end
end