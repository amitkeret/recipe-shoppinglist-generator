import { log, keysort, parseURL } from './funcs.coffee'

# Takes an array of recipes and returns unique ingredients with amount sums
uniqueIngredients = (recipes)->
  ings = {}
  recipes.forEach (recipe)->
    recipe.ingredients.forEach (ing)->
      ings[ing.department] = {} if not ings[ing.department]
      if not ings[ing.department][ing.name]
        ings[ing.department][ing.name] =
          unit:       ing.unit
          amount:     ing.amount
          department: ing.department
      else
        ings[ing.department][ing.name].amount += ing.amount
  # alphabetise everything
  ing = keysort ing for dep, ing of ings
  keysort ings

import css from '../css/recipe-item.css'
html = require '../pug/recipe-item.pug'
recipeItem = 

  props: [
    'recipe'
    'query'
    'vegfilter'
  ]

  methods:
    getLink: -> if @recipe.link.length is 0 then no else parseURL @recipe.link
    toggleSelectedRecipe: -> @recipe.selected = !@recipe.selected

  computed:

    ingSearch: ->
      if @query.length is 0 then no
      else
        found = (ing.name for ing in @recipe.ingredients when ing.name.replace(///\(e?s\)///, '').split(///[\s-]///).includes @query)
        found[0]

    isVeg: -> not @recipe.ingredients.map( (ing)-> ing.department ).includes 'Meats'

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

  template: html

export { recipeItem, uniqueIngredients }
