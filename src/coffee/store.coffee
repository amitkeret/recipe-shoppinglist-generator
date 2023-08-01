# https://github.com/florian/xStore/blob/master/docs/api-documentation.md

import { log, clone, azsort, uniqueArr, uniqueObj } from './funcs.coffee'

initialise = ->
  store.set 'recipes', []

# 1. Backwards-compatibility: use template as starting point
#    This is for recipes which were created prior to addition of new properties
# 2. Multi-field ingredient sort
#    Sorting ingredients by optional first, to push these to the end of the list
format = (recipes)->
  azsort (Object.assign clone(templates.recipe), recipe, 
  { # field formatting
    servings: parseInt recipe.servings | 0
  },
  { # non-DB additions
    selected: no
    servingsModifier: 1
    ingredients: recipe.ingredients.sort (a, b)-> a.optional - b.optional or a.name.localeCompare b.name
  },
  {} for recipe in recipes), 'name'

unformat = (recipes)->
  recipes = clone recipes
  delete recipe.selected for recipe in recipes
  delete recipe.servingsModifier for recipe in recipes
  recipes

store = new xStore 'ShoppingList_', localStorage
do initialise if not store.get 'recipes'

store.getAll = ->
  recipes = store.get 'recipes'
  format recipes

store.importJSON = (json)->
  db = format JSON.parse json
  store.update db

store.exportJSON = -> unformat store.get 'recipes'

store.update = (recipes)->
  store.set 'recipes', recipes
  recipes

export { store }
