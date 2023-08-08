import { log } from './funcs.coffee'

iconHTML = require '../pug/icon.pug'
buttonIconHTML = require '../pug/button-icon.pug'
checkboxHTML = require '../pug/checkbox.pug'

base = [
  'icon', 'color'
  'family'  # meaning the icon-family [fas|far|...]
]

icon =
  props: base
  methods:
    getStyle: -> @family ? 'fas'
  computed:
    compIcon:   -> "#{do @getStyle} fa-#{@icon}"
    compColor:  -> if @color then "text-#{@color}" else ''
    compClass:  -> "#{@compIcon} #{@compColor}"
  template: iconHTML

buttonIcon =
  props: base.concat ['tag', 'text']
  methods:
    buttonClick: ->
      @$emit 'click'
      do @$el.blur
  computed:
    compColor:  -> if @color then "btn-#{@color}" else 'btn-secondary'
    compTag:    -> @tag ? 'button'
    children:   -> (a for a in [@icon, @text] when a?).length
  template: buttonIconHTML

checkbox =
  props: ['boolean']
  computed:
    icon: ->    if @boolean then 'check-square' else 'square'
    family: ->  if @boolean then 'fas' else 'far'
    color: ->   if @boolean then 'primary' else ''
  template: checkboxHTML

export { icon, buttonIcon, checkbox }
