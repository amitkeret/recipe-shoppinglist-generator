import cssApp from '../css/app.css'
import cssOverwrites from '../css/overwrites.css'

import { log, clone, sum, nlbr, parseURL, fraction } from './funcs.coffee'
import { store as db, defaults } from './store.coffee'
import { sectionTitle } from './section-title.coffee'
import { recipeItem } from './recipe-item.coffee'
import * as Ingredients from './recipe-ingredients.coffee'

import { icon, buttonIcon } from './icon.coffee'  # these components are used by multiple other components
Vue.component 'icon', icon                        # importing globally -> available to any component, negates repetative inclusion
Vue.component 'button-icon', buttonIcon           # @see https://vuejs.org/guide/components/registration.html

appConfig = 

  el: '#app'

  components:
    'section-title': sectionTitle
    'vue-multiselect': VueMultiselect.default
    'recipe-item': recipeItem
  
  data: ->
    recipes: []
    editindex: -1
    today: (new Date).toLocaleDateString 'en-AU',
      weekday: 'short'
      year: 'numeric'
      month: 'long'
      day: 'numeric'
    recipe:     clone defaults.recipe
    ingredient: clone defaults.ingredient
    activeRecipe: null
    ingForm: 'exist'
    units: Ingredients.units
    filters:
      query: ''
      ings: []
      ingModeAnd: no
      veg: no
    step1visible: no

  created: ->
    @recipes = do db.getAll
    mess = new Mess
    do mess.init
    do $('[data-toggle="tooltip"]').tooltip

  methods:

    nlbr: (str)-> nlbr str

    addIngredient: ->
      # vue-multiselect is bound to ingredient.name
      # however, it stores (and sends) ingredient objects, not just names
      @ingredient.name = @ingredient.name.name if @ingredient.name.name?

      if @ingredient.name is '' then mess.show 'Ingredient name cannot be empty'
      else if @ingredient.department is '' then mess.show 'Please input department name'
      else if @ingredient.amount is '' then mess.show 'Please input a decimal number'
      else
        @recipe.ingredients.push @ingredient
        do @clearIngredient

    optionalIngredient: (index)-> @recipe.ingredients[index].optional = not @recipe.ingredients[index].optional

    deleteIngredient: (index)-> @recipe.ingredients.splice index, 1

    clearIngredient: (type = 'exist')->
      @ingredient = clone defaults.ingredient
      @ingForm = type

    updateExistingIngredient: (selected)->
      @ingredient.department = selected.department
      @ingredient.unit = selected.unit

    fraction: (num)-> fraction num, yes
    getImage: (recipe)-> if recipe.image is '' then no else parseURL recipe.image

    # Set one of the list recipes to be the active recipe (for the placeholder)
    # Any updates to the underlying recipe object should be reflected immediately in the active recipe
    setActiveRecipe: (index)->
      @activeRecipe = @recipes[index]

    saveRecipe: ->
      if @recipe.name is '' then mess.show 'Name: Cannot be empty'
      else if @recipe.ingredients.length is 0 then mess.show 'Ingredients: Add some first'
      else if @recipe.servings? and @recipe.servings % 1 isnt 0 then mess.show 'Servings: Whole numbers only'
      else
        formatted = db.convert @recipe, 'Vue'
        if @editindex > -1
          @recipes[@editindex] = formatted
          mess.show "Updated recipe: #{@recipe.name}"
          @step1visible = no
        else
          @recipes.push formatted
          mess.show "Added new recipe: #{@recipe.name}"
        do @clearRecipe
        db.update @recipes

    deleteRecipe: (index)->
      app = @
      eModal.confirm 'This cannot be undone.', 'Are you sure?'
        .then ->
          app.recipes.splice index, 1
          db.update app.recipes

    clearRecipe: ->
      @recipe = clone defaults.recipe
      do @clearIngredient
      @editindex = -1

    updateRecipe: (index)->
      @recipe = clone @recipes[index]
      @editindex = index
      @step1visible = yes

    eModalRecipe: (index)->
      @setActiveRecipe(index)
      @step1visible = no
      app = @
      cb = -> eModal.alert
        title:    app.activeRecipe.name
        subtitle: app.$refs.recipePlaceholderLink.outerHTML
        message:  app.$refs.recipePlaceholder.outerHTML
      # allow time for Vue to update DOM
      setTimeout(cb, 100)

    onCopy: (e) -> eModal.alert
        title:    'Copied'
        subtitle: '(<kbd>Ctrl</kbd> + <kbd>v</kbd> to paste)'
        message:  nlbr e.text
    onError: (e) -> mess.show 'Error copying to the clipboard.'

    selectNone: -> recipe.selected = no for recipe in @recipes
    
    clearQuery: ->
      @filters.query = ''
      do this.$refs.query.focus

    step1toggle: ->
      do @clearRecipe
      @step1visible = not @step1visible

    handleFileSelect: (evt)->
      onloadend = (e)->
        jsonStr = new TextDecoder().decode e.target.result # @see https://stackoverflow.com/a/65272548
        @recipes = db.importJSON jsonStr
        mess.show "#{ @recipes.length } recipes loaded successfully."
      reader = new FileReader
      reader.onloadend = onloadend.bind @
      reader. readAsArrayBuffer evt.target.files[0]

    exportRecipes: ->
      str = JSON.stringify (do db.exportJSON), undefined, 2 # @see https://stackoverflow.com/a/7220510
      textToSaveAsBlob = new Blob [str], type: 'text/json'
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

    selectedRecipes: -> (recipe for recipe in @recipes when recipe.selected is yes)

    selectedRecipesTitle: -> (recipe.name for recipe in @selectedRecipes).join(', ').toUpperCase()

    selectedRecipesServings: -> sum (recipe.servings * recipe.servingsModifier for recipe in @selectedRecipes)

    ingredientList: -> (department: dep, ings: (details for name, details of ings) for dep, ings of Ingredients.unique @recipes)
    ingredientListFlat: -> Ingredients.unique @recipes, no
    departmentList: -> Object.keys Ingredients.unique @recipes

    clipboardShoppingList: ->
      a = "Shopping list for #{@today}:\n\n"
      departments = Ingredients.unique @selectedRecipes
      for department, ingredients of departments
        a += "#{ department }:\n"
        a += "#{ fraction ing.amount }#{ ing.unit } #{ ing.name }\n" for ing in ingredients
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

document.addEventListener 'DOMContentLoaded', -> app = new Vue appConfig
