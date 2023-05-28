import { log, clone, azsort, keysort, parseURL } from './funcs.coffee'

formatRecipe = (recipe)->
  cloned = clone recipe
  cloned.servings = parseInt cloned.servings if cloned.servings?
  ing.amount = parseFloat ing.amount for ing in cloned.ingredients
  delete cloned.selected if cloned.selected?
  cloned

# Takes an array of recipes and returns unique ingredients with amount sums
uniqueIngredients = (recipes, groupDeps = yes)->
  ings = {}
  for recipe in recipes
    for ing in recipe.ingredients
      ings[ing.department] = {} if not ings[ing.department]
      if not ings[ing.department][ing.name]
        ings[ing.department][ing.name] =
          name:       ing.name
          unit:       ing.unit
          amount:     ing.amount
          department: ing.department
      else
        ings[ing.department][ing.name].amount += ing.amount
  # Convert to array
  ings[dep] = azsort (details for name, details of ing), 'name' for dep, ing of ings
  if groupDeps is yes then keysort ings
  else azsort (Object.values(ings).flat()), 'name'

import css from '../css/recipe-item.css'
html = require '../pug/recipe-item.pug'
recipeItem =

  props: [
    'recipe'
    'filters'
  ]

  methods:
    getLink: -> if @recipe.link.length is 0 then no else parseURL @recipe.link
    toggleSelectedRecipe: -> @recipe.selected = !@recipe.selected

  computed:

    ingSearch: ->
      if @filters.ings.length is 0 then no
      else
        self = @
        found = @recipe.ingredients.filter (ing)->
          for fing in self.filters.ings
            if ing.name is fing.name then return yes
          no
        found[0]

    isVeg: -> not @recipe.ingredients.map( (ing)-> ing.department ).includes 'Meats'

    showItem: ->
      conditions =
        AND:
          veg:      @filters.veg is no or @isVeg is yes
          ings:     @ingSearch?
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

export { recipeItem, formatRecipe, uniqueIngredients }
