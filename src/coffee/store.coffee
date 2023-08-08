# https://github.com/florian/xStore/blob/master/docs/api-documentation.md

import { log, clone, azsort } from './funcs.coffee'

defaults =
  recipe:
    name:        ''
    link:        ''
    comment:     ''
    image:       ''
    servings:    null
    rating:      null
    ingredients: []
  ingredient:
    name:       ''
    department: ''
    amount:     0
    unit:       null
    optional:   no

initialise = ->
  store.set 'recipes', []

objectFields =
  JSON: [
    {name: 'name'}, {name: 'link'}, {name: 'comment'}, {name: 'image'}
    {name: 'servings', formatFunc: (val)-> parseInt val | 0}
    {name: 'rating', formatFunc: (val)-> parseInt val | 0}
    {
      name: 'ingredients', init: []
      formatFunc: (ings)->
        ing.amount = parseFloat ing.amount for ing in ings
        # Multi-field ingredient sort:
        # Sorting ingredients by optional first, to push these to the end of the list
        ings.sort (a, b)-> a.optional - b.optional or a.name.localeCompare b.name
    }
  ]
objectFields.Vue = objectFields.JSON.concat [
  {name: 'selected', init: no}
  {name: 'servingsModifier', init: 1}
]
# Conversion function between types of storage:
# - JSON file- slimmed-down version, confirm correct field types
# - Vue- added fields for Vue / lists etc.
# Takes recipe/s and adds/removes/formats field as necessary
convert = (recipes = [], toFormat = 'JSON')->

  # make sure we have an array of objects
  recipes = [recipes] if not Array.isArray recipes

  # create a copy; do not affect the original object sent to this function
  # eg. Vue-formatted objects will still be used by Vue after being saved to JSON file
  recipes = clone recipes

  # choose the fields corresponding to the format we're dealing with
  fields = objectFields[toFormat].map (e)-> e.name

  # clear any unnecessary fields
  delete recipe[prop] for prop of recipe when not fields.includes prop for recipe in recipes

  # initialise appropriate fields
  recipe[field.name] = field.init for field in objectFields[toFormat] when field.init? and not recipe[field.name]? for recipe in recipes

  # format all remaining fields
  recipe[field.name] = field.formatFunc recipe[field.name] for field in objectFields[toFormat] when field.formatFunc? for recipe in recipes

  # final alphabetical sorting
  recipes = azsort recipes, 'name'

  if recipes.length is 1 then recipes[0] else recipes

store = new xStore 'ShoppingList_', localStorage
do initialise if not store.get 'recipes'

store.convert = convert

store.getAll = -> convert (store.get 'recipes'), 'Vue'

store.importJSON = (json)->
  recipes = convert (JSON.parse json), 'Vue'
  store.update recipes
  recipes

store.exportJSON = -> convert (store.get 'recipes'), 'JSON'

store.update = (recipes)-> store.set 'recipes', convert recipes, 'Vue'

export { store, defaults }
