import { log, clone, azsort, nlbr, parseURL, fraction } from './funcs.coffee'
import { store as db } from './xStore.coffee'
mess = new Mess

templates =
  recipe:
    name:        ''
    ingredients: []
    link:        ''
    comment:     ''
    servings:    null
    image:       ''
  ingredient:
    name:       ''
    unit:       null
    amount:     0
    department: ''
    optional:   no

import { icon, buttonIcon } from './icon.coffee'
import { sectionTitle } from './section-title.coffee'
import { recipeItem, uniqueIngredients } from './recipe-item.coffee'
Vue.component 'vue-multiselect', VueMultiselect.default
Vue.component 'icon', icon
Vue.component 'button-icon', buttonIcon
Vue.component 'section-title', sectionTitle
Vue.component 'recipe-item', recipeItem

appConfig = 

  el: '#app'
  data:
    recipes: []
    editindex: ''
    today: (new Date).toLocaleDateString 'en-AU',
      weekday: 'short'
      year: 'numeric'
      month: 'long'
      day: 'numeric'
    recipe:     clone templates.recipe
    ingredient: clone templates.ingredient
    ingForm: 'exist'
    units: ['', 'mL', 'g', ' cup(s)', ' tbsp(s)', ' tsp(s)', ' pack(s)']
    query: ''
    vegfilter: no
    step1visible: no

  methods:

    updateRecipeDB: (overwrite = null)->
      # 1. Backwards-compatibility: use template as starting point
      #    This is for recipes which were created prior to addition of new properties
      # 2. Multi-field ingredient sort
      #    Sorting ingredients by optional first, to push these to the end of the list
      recipes = (Object.assign clone(templates.recipe), recipe, {
        selected: no
        ingredients: recipe.ingredients.sort (a, b)-> a.optional - b.optional or a.name.localeCompare b.name
      } for recipe in overwrite ? @recipes)
      @recipes = azsort recipes, 'name'
      db.set 'recipes', @recipes

    nlbr: (str)-> nlbr str

    addIngredient: ->
      # vue-multiselect is bound to ingredient.name
      # however, it stores (and sends) ingredient objects, not just names
      @ingredient.name = @ingredient.name.name if @ingredient.name.name?

      if @ingredient.name is '' then mess.show 'Ingredient name cannot be empty'
      else if @ingredient.department is '' then mess.show 'Please input department name'
      else if @ingredient.amount is '' then mess.show 'Please input a decimal number'
      else
        @recipe.ingredients.push Object.assign @ingredient, amount: parseFloat @ingredient.amount
        do @clearIngredient

    optionalIngredient: (index)-> @recipe.ingredients[index].optional = not @recipe.ingredients[index].optional

    deleteIngredient: (index)-> @recipe.ingredients.splice index, 1

    clearIngredient: (type = 'exist')->
      @ingredient = clone templates.ingredient
      @ingForm = type

    updateExistingIngredient: (selected)->
      @ingredient.department = selected.department
      @ingredient.unit = selected.unit

    fraction: (num)-> fraction num, yes
    getImage: (recipe)-> if recipe.image is '' then no else parseURL recipe.image

    addRecipe: ->
      if @recipe.name is '' then mess.show 'Name: Cannot be empty'
      else if @recipe.ingredients.length is 0 then mess.show 'Ingredients: Add some first'
      else if @recipe.servings? and @recipe.servings % 1 isnt 0 then mess.show 'Servings: Whole numbers only'
      else
        if @editindex isnt ''
          @recipes[@editindex][prop] = @recipe[prop] for prop of @recipe when prop isnt 'selected'
          mess.show "Updated recipe: #{@recipe.name}"
        else
          @recipes.push clone @recipe
          mess.show "Added new recipe: #{@recipe.name}"
        do @clearRecipe
      do @updateRecipeDB

    deleteRecipe: (index)->
      app = @
      eModal.confirm 'This cannot be undone.', 'Are you sure?'
        .then ()->
          app.recipes.splice index, 1
          do app.updateRecipeDB

    clearRecipe: ->
      @recipe = clone templates.recipe
      do @clearIngredient
      @editindex = ''

    updateRecipe: (index, recipe)->
      @recipe[prop] = value for prop, value of recipe
      @editindex = index
      @step1visible = yes

    eModalRecipe: (recipe)->
      @step1visible = no
      @recipe[prop] = value for prop, value of recipe
      app = @
      cb = -> eModal.alert
        title:    recipe.name
        subtitle: app.$refs.recipePlaceholderLink.outerHTML
        message:  app.$refs.recipePlaceholder.outerHTML
      # allow time for Vue to update DOM
      setTimeout(cb, 100)

    # Takes an array of recipes and returns unique ingredients with amount sums
    uniqueIngredients: (recipes = @recipes)->
      ings = {}
      recipes.forEach (recipe)->
        recipe.ingredients.forEach (ing)->
          ings[ing.department] = {} if not ings[ing.department]
          if not ings[ing.department][ing.name]
            ings[ing.department][ing.name] =
              unit:       ing.unit
              amount:     ing.amount
              department: ing.department
          else
            ings[ing.department][ing.name].amount += ing.amount
      # alphabetise everything
      ordered = {}
      for d in azsort Object.keys ings
        ordered[d] = {}
        ordered[d][i] = ings[d][i] for i in azsort Object.keys ings[d]
      ordered

    onCopy: (e) -> eModal.alert
        title:    'Copied'
        subtitle: '(<kbd>Ctrl</kbd> + <kbd>v</kbd> to paste)'
        message:  nlbr e.text
    onError: (e) -> mess.show 'Error copying to the clipboard.'

    selectNone: -> @recipes.forEach (recipe)-> recipe.selected = no
    clearQuery: ->
      @query = ''
      do this.$refs.query.focus
    toggleVeg: -> @vegfilter = not @vegfilter

    step1toggle: ->
      do @clearRecipe
      @step1visible = not @step1visible

    handleFileSelect: (evt)->
      onload = (e)->
        @recipes = db.importJSON e.target.result
        mess.show "#{ @recipes.length } recipes loaded successfully."
      # https://www.html5rocks.com/en/tutorials/file/dndfiles/
      reader = new FileReader
      reader.onload = onload.bind @
      reader.readAsBinaryString evt.target.files[0]

    prepareDBforDownload: ->
      data = clone @recipes
      for recipe in data
        delete recipe.selected
        delete recipe.index
        recipe.servings = parseInt recipe.servings if recipe.servings?
      data

    exportRecipes: ->
      records = do @prepareDBforDownload
      textToSaveAsBlob = new Blob [JSON.stringify @recipes, undefined, 2], type: 'text/json'
      downloadLink = document.createElement 'a'
      Object.assign downloadLink,
        download:   'recipes.json'
        innerHTML:  'Download File'
        href:       window.URL.createObjectURL textToSaveAsBlob
        onclick:    (e)-> document.body.removeChild e.target
      downloadLink.style.display = 'none'
      document.body.appendChild downloadLink
      do downloadLink.click

  computed:
    selectedRecipes: -> @recipes.filter (recipe)-> recipe.selected is yes
    selectedRecipesTitle: ->
      s = @selectedRecipes.map (recipe)-> recipe.name
      s.join ', '
        .toUpperCase()

    ingredientList: -> (department: dep, ings: (Object.assign details, {
      name: name
    } for name, details of ings) for dep, ings of uniqueIngredients @recipe)
    departmentList: -> Object.keys uniqueIngredients @recipe

    clipboardShoppingList: ->
      a = "Shopping list for #{@today}:\n\n"
      departments = uniqueIngredients @selectedRecipes
      for department, ingredients of departments
        a += "#{ department }:\n"
        a += "#{ fraction ing.amount }#{ ing.unit } #{ ingName }\n" for ingName, ing of ingredients
        a += '\n'
      a
    clipboardMenues: ->
      a = "Menu for #{ @today }:\n#{ @selectedRecipesTitle }\n\n"
      for recipe in @selectedRecipes
        a += "#{ recipe.name.toUpperCase() }
              #{ if recipe.comment then '\n' + recipe.comment else '' }
              \n--------------------------------------------\n"
        a += "#{ fraction ing.amount }#{ ing.unit } #{ ing.name }\n" for ing in recipe.ingredients
        a += '\n'
      a

document.addEventListener 'DOMContentLoaded', ->
  do mess.init
  app = new Vue appConfig
  app.recipes = db.get 'recipes'
