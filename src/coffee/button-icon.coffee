module.exports =

  props: [
    'text'
    'icon', 'family', 'color'
    'tag'
  ]

  methods:

    buttonClick: ->
      this.$emit 'buttonclick'
      do this.$el.blur

  computed:

    compIcon:   -> "#{do @getStyle} fa-#{@icon}"
    compColor:  -> if @color then "btn-#{@color}" else 'btn-secondary'
    compTag:    -> @tag ? 'button'
    children:   -> (a for a in [@icon, @text] when a?).length

  template: '#button-icon'
