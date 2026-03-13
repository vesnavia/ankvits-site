# Дизайн-система проекта (Основано на Главной странице)

Этот документ описывает настоящий визуальный язык сайта, заложенный в `assets/css/style.css`.
При создании новых страниц или кейсов следует опираться на эти устои для сохранения консистентности.

## Токены (CSS Custom Properties)

Все базовые цвета и переменные определены в `:root` файла `style.css`:

```css
:root {
  --bg-color: #111111;
  --text-color: #ffffff;
  --text-secondary: #888888;
  --border-color: #333333;
  --accent-red: #d32f2f;
  --contact-red: #d33a3a;
  --control-radius: 12px;
  --tag-bg: #1a1a1a;
  --font-main: "Montserrat", sans-serif;
}
```

## Типографика
- **Базовый шрифт**: Montserrat (`var(--font-main)`)
- **Базовый размер/line-height**: `line-height: 1.5`, сглаживание шрифтов включено (`-webkit-font-smoothing: antialiased`).
- **Заголовки секций (`H2`)**: `font-size: 2rem`, `text-transform: uppercase`, `font-weight: 400` (для секций типа Обо мне — `font-weight: 300`).
- **Главный заголовок (`H1`)**: `font-size: 4rem`, `font-weight: 300`, `letter-spacing: -2px`.
- **Подзаголовки/Метки (e.g. `.section-subtitle`)**: `font-size: 0.8rem`, `text-transform: uppercase`, `letter-spacing: 2px`.

## Сетка и Лейаут
- **Основной контейнер (`.grid-container`)**:
  - `max-width: 1600px`
  - Центрирование (`margin: 0 auto`)
  - Левая и правая границы: `1px solid var(--border-color)`
- **Разделение секций**:
  - Секции (Обо мне, Кейсы, Карьера) разделяются снизу бордером: `border-bottom: 1px solid var(--border-color)`.
  - Внутри секций используется CSS Grid: `display: grid; grid-template-columns: 350px 1fr;` (левая колонка заголовок/фильтр, правая — контент).
  - На мобильных устройствах сетка схлопывается в `1fr`.

## Компоненты

### Кнопки
1. **Primary (`.btn-primary`)**:
   - Градиент: `linear-gradient(140deg, #d33a3a 0%, #b72a2a 100%)`
   - Обводка: `1px solid #d95b5b`
   - Тень: `0 10px 24px rgba(211, 47, 47, 0.24)`
   - Скругление: `var(--control-radius)` (12px)
2. **Secondary (`.btn-secondary`)**:
   - Фон: `rgba(255, 255, 255, 0.04)`
   - Обводка: `1px solid rgba(255, 255, 255, 0.24)`
   - Hover-состояние: `background: rgba(255, 255, 255, 0.1)`, граница ярче.

### Карточки кейсов (`.case-card`)
- `border-bottom: 1px solid var(--border-color)`
- При наведении фон меняется на `#161616`.
- Изображение увеличивается (`transform: scale(1.02); filter: saturate(1.08);`), если карточка кликабельная.
- Ссылка (`.case-link`) подчеркивается на hover/focus.

### Теги / Навыки (`.skills-tags span`)
- Заливка: `var(--tag-bg)` (#1a1a1a)
- Скругление: `var(--control-radius)` (12px)
- Взаимодействие (Hover): Цвет фона меняется на `var(--accent-red)`.

### Отступы (Padding)
- Для крупных блоков (e.g. Header, Hero, Обо мне): отступы варьируются от `2rem` до `6rem` сверху/снизу. Для внутренних карточек (кейсы, карьера) используется `padding: 3rem`.
- На мобильных устройствах padding уменьшается до `1.5rem` - `2rem`.
