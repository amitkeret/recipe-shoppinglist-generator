import { log, clone, sum, parseURL, validate } from './funcs.coffee'
import { store as db, defaults } from './store.coffee'
import { recipeServings } from './recipe-servings.coffee'

data =
  recipe: clone defaults.recipe
  activeRecipe: null

methods = ->

  vue = @

  # Set one of the list recipes to be the active recipe (for the placeholder)
  # Any updates to the underlying recipe object should be reflected immediately in the active recipe
  setActive: (index)-> vue.Recipe.activeRecipe = vue.recipes[index]

  clear: ->
    vue.Recipe.recipe = clone defaults.recipe
    do vue.Ingredients.clear
    vue.step1visible = no if vue.editindex > -1
    vue.editindex = -1

  save: ->

    conditions = [
      [ 'name',         '',                         'Recipe name: Cannot be empty']
      [ 'ingredients',  (prop)-> prop.length is 0,  'Ingredients: Add at least one ingredient']
      [ 'servings',     (prop)-> prop % 1 isnt 0,   'Servings: Whole numbers only (1-10)']
      [ 'rating',       (prop)-> prop % 1 isnt 0,     'Rating: Whole numbers only (1-5)']
    ]

    if validate vue.Recipe.recipe, conditions
      formatted = db.convert vue.Recipe.recipe, 'Vue'
      if vue.editindex > -1
        vue.recipes[vue.editindex] = formatted
        vue.step1visible = no
      else
        vue.recipes.push formatted
      mess.show "#{if vue.editindex > -1 then 'Updated' else 'Added new'} recipe: #{vue.Recipe.recipe.name}"
      do vue.Recipes.clear
      db.update vue.recipes

  delete: (index)->
    eModal.confirm 'This cannot be undone.', 'Are you sure?'
      .then ->
        vue.recipes.splice index, 1
        db.update vue.recipes

  update: (index)->
    vue.Recipe.recipe = clone vue.recipes[index]
    vue.editindex = index
    vue.step1visible = yes

  eModal: (index)->
    vue.Recipes.setActive(index)
    vue.step1visible = no
    cb = -> eModal.alert
      title:    vue.Recipe.activeRecipe.name
      subtitle: vue.$refs.recipePlaceholderLink.outerHTML
      message:  vue.$refs.recipePlaceholder.outerHTML
    # allow time for Vue to update DOM
    setTimeout(cb, 100)

  selected: (partial = null)->
    selected = (recipe for recipe in vue.recipes when recipe.selected is yes)
    switch partial
      when 'title' then (recipe.name for recipe in selected).join(', ').toUpperCase()
      when 'servings' then sum (recipe.servings * recipe.servingsModifier for recipe in selected)
      else selected

import css from '../css/recipe-item.css'
html = require '../pug/recipe-item.pug'
component =

  components:
    'recipe-servings': recipeServings

  props: [
    'recipe'
    'filters'
  ]

  methods:
    getLink: -> if @recipe.link.length is 0 then no else parseURL @recipe.link

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

    isVeg: -> (ing for ing in @recipe.ingredients when ing.department is 'Meats').length is 0

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

export { component, data, methods }
