import { log, clone } from './funcs.coffee'

base = [
  'icon', 'color'
  'family'  # meaning the icon-family [fas|far|...]
]

html = require '../pug/icon.pug'
icon =
  props: base
  methods:
    getStyle: -> @family ? 'fas'
  computed:
    compIcon:   -> "#{do @getStyle} fa-#{@icon}"
    compColor:  -> if @color then "text-#{@color}" else ''
    compClass:  -> "#{@compIcon} #{@compColor}"
  template: clone html

html = require '../pug/button-icon.pug'
buttonIcon =
  props: base.concat ['tag', 'text', 'textBreakpoint']
  methods:
    buttonClick: ->
      @$emit 'click'
      do @$el.blur
  computed:
    compColor:  -> if @color then "btn-#{@color}" else 'btn-secondary'
    compTag:    -> @tag ? 'button'
    children:   -> (a for a in [@icon, @text] when a?).length
    compTextClass: ->
      cl = [
        if @textBreakpoint? then "d-none d-#{@textBreakpoint}-inline" else ''
        if @children > 1 then "ml-#{ if @textBreakpoint? then "#{ @textBreakpoint }-" else '' }2" else ''
      ]
      cl.join ' '
  template: clone html

html = require '../pug/checkbox.pug'
checkbox =
  props: ['checked']
  computed:
    icon: ->    if @checked then 'check-square' else 'square'
    family: ->  if @checked then 'fas' else 'far'
    color: ->   if @checked then 'primary' else ''
  template: clone html

html = require '../pug/dropdown-item.pug'
dropdownItem =
  props: [
    'icon'
    'color'
    'text'
    'suffix'
    'keepMenu'
  ]
  methods:
    dropdownClick: (e)->
      @$emit 'click'
      do e.stopPropagation if @keepMenu is yes
  template: clone html

html = require '../pug/section-title.pug'
sectionTitle =
  props: [
    'title'           # the title
    'text'            # option 1: prepend text
    'icon', 'family'  # option 2: prepend icon
    'suffixIcon'
  ]
  template: clone html

export { icon, buttonIcon, checkbox, dropdownItem, sectionTitle }
