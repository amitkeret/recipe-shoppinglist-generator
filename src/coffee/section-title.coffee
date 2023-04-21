import css from '../css/section-title.css'
html = require '../pug/section-title.pug'

sectionTitle =
  props: [
    'title'           # the title
    'text'            # option 1: prepend text
    'icon', 'family'  # option 2: prepend icon
  ]
  template: html

export { sectionTitle }
