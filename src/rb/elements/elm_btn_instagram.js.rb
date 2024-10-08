export default class ElmBtnInstagram < HTMLElement
  def initialize
    super
    
    @words = Language.relevant.btn_instagram

    init_elm()
  end

  def connected_callback()
  end

  def disconnected_callback()
  end

  def init_elm()
    template = """
<div class='instagram-link' style='text-align: center; margin-top: 20px;'>
  <a href='https://www.instagram.com/pavelkrcmarspain' target='_blank' style='display: inline-block; padding: 10px 20px; background-color: #E1306C; color: white; text-decoration: none; border-radius: 5px; font-size: 16px; font-weight: bold;'>
    <i class='bi bi-instagram'></i>
    #{@words[0]}
  </a>
</div>
    """

    self.innerHTML = template
  end
end