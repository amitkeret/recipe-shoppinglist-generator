module.exports =

  props: [
    'icon', 'color'
    'family'  # meaning the icon-family [fas|far|...]
  ]

  methods:

    getStyle: -> @family ? 'fas'

  computed:

    compIcon:   -> "#{do @getStyle} fa-#{@icon}"
    compColor:  -> if @color then "text-#{@color}" else ''
    compClass:  -> "#{@compIcon} #{@compColor}"

  template: '#icon'
