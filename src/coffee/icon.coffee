iconHTML = require '../pug/icon.pug'
buttonIconHTML = require '../pug/button-icon.pug'

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
      this.$emit 'buttonclick'
      do this.$el.blur
  computed:
    compColor:  -> if @color then "btn-#{@color}" else 'btn-secondary'
    compTag:    -> @tag ? 'button'
    children:   -> (a for a in [@icon, @text] when a?).length
  template: buttonIconHTML

export { icon, buttonIcon }
