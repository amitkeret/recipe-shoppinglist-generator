import { log, parseURL } from './funcs.coffee'
import { recipeServings } from './recipe-servings.coffee'

import css from '../css/recipe-item.css'
html = require '../pug/recipe-item.pug'
recipeItem =

  components:
    'recipe-servings': recipeServings

  props: [
    'recipe'
    'filters'
  ]

  methods:
    getLink: -> if @recipe.link.length is 0 then no else parseURL @recipe.link
    toggleSelectedRecipe: -> @recipe.selected = !@recipe.selected

  computed:

    ingSearch: ->
      fings = (ing.name for ing in @filters.ings)
      found = (ing for ing in @recipe.ingredients when fings.includes ing.name)

    showIngs: ->
      show = yes
      if @filters.ings.length isnt 0
        if @filters.ingModeAnd is yes
          show = @ingSearch.length is @filters.ings.length
        else
          show = @ingSearch.length > 0
      show

    isVeg: -> not @recipe.ingredients.map( (ing)-> ing.department ).includes 'Meats'

    showItem: ->
      conditions =
        AND:
          veg:      @filters.veg is no or @isVeg is yes
          ings:     @showIngs
        OR:
          empty:    @filters.query.length is 0
          title:    @recipe.name.toLowerCase().includes(@filters.query)
          comment:  @recipe.comment.toLowerCase().includes(@filters.query)
      ands = Object.values conditions.AND
        .every (e)-> e is yes
      ors  = Object.values conditions.OR
        .includes yes
      final = ors is yes and ands is yes

  template: html

export { recipeItem }
