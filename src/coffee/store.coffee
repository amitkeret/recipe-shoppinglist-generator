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

export { store }
