import 'csObj', '../../json/languages/cs.json'

export default class Language
  def self.relevant
    # TODO: Kód jazyka má být dynamicky orientovaný
    #       podle nastavení prohlížeče.
    code_lang = :cs

    case code_lang
    when :cs, 'cs-CZ'
      return cs_obj
    else
      return cs_obj
    end
  end
end
window.Language = Language
