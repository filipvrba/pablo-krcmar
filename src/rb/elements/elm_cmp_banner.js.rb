export default class ElmCmpBanner < HTMLElement
  def initialize
    super
    
    @h_accept_cookies_click = lambda { accept_all_cookies() }
    @h_reject_cookies_click = lambda { reject_all_cookies() }

    init_elm()

    @cmp_banner = self.query_selector('#cmp-banner')
    @accept_cookies = self.query_selector('#accept-cookies')
    @reject_cookies = self.query_selector('#reject-cookies')
  end

  def connected_callback()
    @accept_cookies.add_event_listener('click', @h_accept_cookies_click)
    @reject_cookies.add_event_listener('click', @h_reject_cookies_click)

    show_banner()
  end

  def disconnected_callback()
    @accept_cookies.remove_event_listener('click', @h_accept_cookies_click)
    @reject_cookies.remove_event_listener('click', @h_reject_cookies_click)
  end

  def show_banner()
    unless local_storage.getItem('userConsent')
      @cmp_banner.class_list.remove('d-none')
    end
  end

  def hide_banner()
    @cmp_banner.class_list.add('d-none')
  end

  def accept_all_cookies()
    local_storage.set_item('userConsent', 'all')
    manage_cookies(true)
    hide_banner()
  end

  def reject_all_cookies()
    local_storage.set_item('userConsent', 'none')
    manage_cookies(false)
    hide_banner()
  end

  def manage_cookies(allow_cookies)
    if allow_cookies
      gtag('consent', 'update', {
        'ad_storage': 'granted',
        'analytics_storage': 'granted'
      })
    else
      gtag('consent', 'update', {
        'ad_storage': 'denied',
        'analytics_storage': 'denied'
      })
    end
  end

  def init_elm()
    template = """
<div id='cmp-banner' class='d-none'>
  <div class='container'>
    <h5>Vaše soukromí je pro nás důležité</h5>
    <p>
      Tento web používá cookies k ukládání údajů o vaší návštěvě a klikání na rubriky pro zlepšení našich služeb.
      Souhlasíte s tímto sledováním? Více informací naleznete v <a href='/privacy-policy' target='_blank' style='color: #17a2b8;'>zásadách ochrany osobních údajů</a>.
    </p>
    <div class='cmp-options'>
      <button class='btn btn-success btn-sm' id='accept-cookies'>Přijmout vše</button>
      <button class='btn btn-danger btn-sm' id='reject-cookies'>Odmítnout vše</button>
      <button class='btn btn-secondary btn-sm' id='customize-cookies'>Nastavit</button>
    </div>
  </div>
</div>
    """

    self.innerHTML = template
  end
end