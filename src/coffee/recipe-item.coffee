funcs = require './funcs.coffee'

module.exports =

  props: [
    'recipe'
    'recipes'
    'index'
    'query'
    'vegfilter'
  ]

  methods:

    getLink: ->
      if @recipe.link.length is 0 then no
      else funcs.parseURL @recipe.link

    toggleSelectedRecipe: -> @recipe.selected = !@recipe.selected

  computed:

    ingSearch: ->
      if @query.length is 0 then no
      else
        ings = (ing.name.replace(///\(e?s\)///, '').split(' ') for ing in @recipe.ingredients)
        found = (@recipe.ingredients[i].name for ing, i in ings when ing.includes @query)[0]

    isVeg: ->
      deps = (ing.department for ing in @recipe.ingredients)
      meat = not deps.includes 'Meats'

    showItem: ->
      conditions =
        AND:
          veg:   @vegfilter is no or @isVeg is yes
        OR:
          empty:    @query.length is 0
          title:    @recipe.name.toLowerCase().includes(@query)
          comment:  @recipe.comment.toLowerCase().includes(@query)
          ings:     @ingSearch?
      ands = Object.values conditions.AND
        .every (e)-> e is yes
      ors  = Object.values conditions.OR
        .includes yes
      final = ors is yes and ands is yes

  template: '#recipe-item'
