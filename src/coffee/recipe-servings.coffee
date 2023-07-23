import { log, clone } from './funcs.coffee'

import css from '../css/recipe-servings.css'
html = require '../pug/recipe-servings.pug'
recipeServings =

  props: [
    'recipe'
    'buttons'
  ]

  data:
    originalRecipe: null

  computed:
    original: ->
      if not @originalRecipe? then @originalRecipe = clone @recipe
      @originalRecipe

  methods:
    update: (change)->
      if @recipe.servings + change isnt 0
        @recipe.servings += change
        ing.amount = @original.ingredients[index].amount / @original.servings * @recipe.servings for ing, index in @recipe.ingredients

  template: html

export { recipeServings }
