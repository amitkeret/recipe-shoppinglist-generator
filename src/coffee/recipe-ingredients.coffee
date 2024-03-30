import { log, clone, azsort, keysort, validate } from './funcs.coffee'
import { defaults } from './store.coffee'

data =
  ingredient: clone defaults.ingredient
  units: [
    ''
    'mL'
    'g'
    ' cup(s)'
    ' tbsp(s)'
    ' tsp(s)'
    ' pack(s)'
  ]
  ingForm: 'exist'

# Takes an array of recipes and returns unique ingredients with amount sums
unique = (recipes, groupDeps = yes)->
  ings = {}
  for recipe in recipes
    for ing in recipe.ingredients
      ings[ing.department] = {} if not ings[ing.department]
      if not ings[ing.department][ing.name]
        ings[ing.department][ing.name] =
          name:       ing.name
          unit:       ing.unit
          amount:     ing.amount * recipe.servingsModifier
          department: ing.department
      else
        ings[ing.department][ing.name].amount += ing.amount
  # Convert to array
  ings[dep] = azsort (details for name, details of ing), 'name' for dep, ing of ings
  if groupDeps is yes then keysort ings
  else azsort (Object.values(ings).flat()), 'name'

methods = ->

  vue = @

  unique: unique

  clear: (type = 'exist')->
    vue.Ingredient.ingredient = clone defaults.ingredient
    vue.Ingredient.ingForm = type

  add: ->

    conditions = [
      [ 'name',       '',   'Ingredient name: Cannot be empty']
      [ 'department', '',   'Department name: Cannot be empty']
      [
        'amount'
        (prop)-> (prop is '') or (isNaN(prop) is yes) or (prop < 0.125) or ((prop * 8) % 1 isnt 0)
        'Amount: Decimal numbers in steps of 0.125'
      ]
      [ 'unit',       null, 'Unit: Selection required']
    ]

    if validate vue.Ingredient.ingredient, conditions
      # vue-multiselect is bound to ingredient.name
      # however, it stores (and sends) ingredient objects, not just names
      vue.Ingredient.ingredient.name = vue.Ingredient.ingredient.name.name if vue.Ingredient.ingredient.name.name?

      vue.Recipe.recipe.ingredients.push vue.Ingredient.ingredient
      do vue.Ingredients.clear

  updateExisting: (selected)->
    vue.Ingredient.ingredient.department = selected.department
    vue.Ingredient.ingredient.unit = selected.unit

  optional: (index)-> vue.Recipe.recipe.ingredients[index].optional = not vue.Recipe.recipe.ingredients[index].optional

  delete: (index)-> vue.Recipe.recipe.ingredients.splice index, 1

  list: -> (department: dep, ings: (details for name, details of ings) for dep, ings of unique vue.recipes)
  listFlat: -> unique vue.recipes, no
  departments: -> Object.keys unique vue.recipes

  ingSearch: (recipe, filters)->
    fings = (ing.name for ing in filters.ings)
    found = (ing for ing in recipe.ingredients when fings.includes ing.name)

import css from '../css/recipe-ingredients.css'
html = require '../pug/recipe-ingredients.pug'
component =

  props: [
    'recipe'
    'filters'
  ]

  computed:
    ingSearch: -> methods().ingSearch @recipe, @filters

  template: html

export { data, methods }
