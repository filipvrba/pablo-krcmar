# 🌍 Pablo Krcmar – Prezentace turismu ve Španělsku

Jednodušší, modulární prezentační web zaměřený na turistické služby pod značkou **Pablo Krcmar**.  
Web prezentuje nabídku služeb ve Španělsku, galerii prostředí a aktuální počasí ve Valencii.

Projekt je postavený na vlastním Vanilla JS frameworku, přičemž vývoj probíhal převážně v **Ruby syntaxi**. Tu překládá do JS nástroj [`rubyjs-vite`](https://filipvrba.github.io/ruby-js/).

---

## 🚀 Funkce webu

- Prezentace turismu ve Španělsku (Valencie a okolí)
- Dynamický routing přes vlastní komponentu
- Vlastní webové komponenty (Custom Elements)
- Galerie a statická data z JSON
- API pro počasí (serverless funkce přes Vercel)
- Vysoký výkon díky statickému přístupu

---

## 🛠 Použité technologie

- **Vanilla JS** (ve vlastní architektuře)
- **Ruby syntaktická vrstva** → transpile do JS (`rubyjs-vite`)
- **Vite** jako vývojový a build nástroj
- **Bootstrap Icons** pro UI
- **Vercel serverless API** pro externí data (např. počasí)

---

## 📁 Struktura projektu

```
.
├── api                # Serverless funkce (Vercel)
├── config             # Konfigurace rubyjs-vite
├── src                # Zdrojové soubory
│   ├── css            # Styly + Bootstrap
│   ├── html           # HTML šablony (pro routování)
│   ├── js             # Přeložený JS (automaticky z src/rb)
│   │   ├── core       # Core logika (singletony, helpers, prototypy)
│   │   ├── elements   # Custom web components
│   │   └── packages   # Opakovaně použitelé balíčky
│   ├── json           # Statická data (DB, router, galerie, překlady)
│   └── rb             # Ruby soubory pro přepis do JS
├── vite.config.js     # Konfigurace vývojového serveru (vite)
```

---

## ⚙️ Spuštění vývoje

> Předpoklad: máš nainstalovaný `Node.js` a `Ruby` (pro psaní v Ruby syntaxi)

```bash
# Instalace závislostí
npm install

# Spuštění vývoje
npm run dev
```

> `rubyjs-vite` zajistí automatický překlad ruby → js souborů, není třeba nic ručně překládat.

---

## 🧰 Webové komponenty (Custom Elements)

Každý vlastní element začíná prefixem `elm-`  
Např. `<elm-introduction>`, `<elm-weather-radar>`, `<elm-priority-routes>` apod.

Najdeš je ve složce:  
`src/js/elements/`  
nebo v registru:  
`src/js/elements.js` (pomoc při hledání konkrétní komponenty)

---

## 🔄 Routing

Vlastní client-side routing probíhá pomocí komponenty:

```html
<elm-priority-routes></elm-priority-routes>
```

- Reaguje na změny hashů v URL (`#about`, `#contact`, apod.)
- HTML šablony se načítají ze složky `src/html`
- Přehled rout a jejich priority: `src/json/routes.json`
- Načítání optimalizováno pomocí `core/routes.js` (raw text -> render)

Ukázka použití v `index.html`:

```html
<elm-header></elm-header>
<div id="app">
  <elm-priority-routes></elm-priority-routes>
  <elm-cmp-banner></elm-cmp-banner>
</div>
<elm-footer year="2024"></elm-footer>
```

---

## 🌤 API – Počasí

- Využívá Vercel serverless funkci (`/api/weather.js`)
- Data o počasí se získávají z externí API služby
- **Privátní API klíč je uložený na Vercelu** (není součástí repozitáře!)

> V `vite.config.js` je nakonfigurován proxy server, aby bylo možné volat API i v development módu.

---

## 📦 Použité balíčky

| Název            | Popis                              |
|------------------|-------------------------------------|
| `vite`           | Dev server + optimalizace buildu    |
| `bootstrap-icons`| Ikonky pro rychlejší návrh UI       |

---

## 📘 Doporučení pro vývojáře

- Pro zachování konzistence používej `rubyjs-vite` a piš logiku v Ruby syntaxi
- Pokud chceš upravovat komponenty, začni průchodem souboru `elements.js`
- Každý element je samostatný modul, který je snadno upravitelný
- Některé komponenty využívají core třídy nebo pomocné utility – podívej se i do `core/`
- API klíče neukládej do projektu – používej prostředí Vercel nebo `.env`

---

## 📩 Kontakt

Autor projektu: **Pablo Krcmar**  
Více informací a kontakt najdete přímo na webu ve stránce **Contact**.

---

Pokud máš jakékoliv dotazy ohledně frameworku nebo jeho využití, otevři issue nebo mě kontaktuj osobně.  
Díky za zájem a hodně štěstí při vývoji! 🚀

