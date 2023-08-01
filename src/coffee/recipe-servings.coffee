import { log, clone } from './funcs.coffee'

import css from '../css/recipe-servings.css'
html = require '../pug/recipe-servings.pug'
recipeServings =

  props: [
    'recipe'
  ]

  computed:
    currentServings: -> @recipe.servings * @recipe.servingsModifier

  methods:
    update: (change)->
      if @currentServings + change isnt 0
        @recipe.servingsModifier = (@currentServings + change) / @recipe.servings

  template: html

export { recipeServings }
