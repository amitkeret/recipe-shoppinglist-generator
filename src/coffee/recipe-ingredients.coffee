import { log, azsort, keysort } from './funcs.coffee'

units = [
  ''
  'mL'
  'g'
  ' cup(s)'
  ' tbsp(s)'
  ' tsp(s)'
  ' pack(s)'
]

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

export { units, unique }
