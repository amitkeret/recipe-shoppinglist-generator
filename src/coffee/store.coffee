# https://github.com/florian/xStore/blob/master/docs/api-documentation.md

import { log, clone, azsort, uniqueArr, uniqueObj } from './funcs.coffee'

initialise = ->
  store.set 'recipes', []

store = new xStore 'ShoppingList_', localStorage
do initialise if not store.get 'recipes'

store.importJSON = (json)->
  db = JSON.parse json
  store.set 'recipes', db
  db

store.update = (recipes)->
  # 1. Backwards-compatibility: use template as starting point
  #    This is for recipes which were created prior to addition of new properties
  # 2. Multi-field ingredient sort
  #    Sorting ingredients by optional first, to push these to the end of the list
  recipes = (Object.assign clone(templates.recipe), recipe, {
    selected: no
    ingredients: recipe.ingredients.sort (a, b)-> a.optional - b.optional or a.name.localeCompare b.name
  } for recipe in recipes)
  store.set 'recipes', azsort recipes, 'name'

export { store }
