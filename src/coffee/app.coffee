import cssApp from '../css/app.css'
import cssOverwrites from '../css/overwrites.css'

import { log, clone, nlbr, parseURL, fraction, randomInteger, timeout } from './funcs.coffee'
import { store as db } from './store.coffee'
import { sectionTitle } from './section-title.coffee'
import * as Recipe from './recipe-item.coffee'
import * as Ingredients from './recipe-ingredients.coffee'

# importing globally -> available to entire app, negates repetative inclusion by multiple other components
# @see https://vuejs.org/guide/components/registration.html
import { icon, buttonIcon, checkbox } from './common-components.coffee'
Vue.component 'icon', icon
Vue.component 'button-icon', buttonIcon
Vue.component 'checkbox', checkbox

appConfig = 

  el: '#app'

  components:
    'section-title': sectionTitle
    'vue-multiselect': VueMultiselect.default
    'recipe-item': Recipe.component

  data: ->
    recipes: []
    editindex: -1
    today: (new Date).toLocaleDateString 'en-AU',
      weekday: 'short'
      year: 'numeric'
      month: 'long'
      day: 'numeric'
    Recipe:     Recipe.data
    Ingredient: Ingredients.data
    filters:
      query: ''
      ings: []
      ingModeAnd: no
      rating: no
      veg: no
    step1visible: no

  created: -> @recipes = do db.getAll

  methods:

    onCopy: (e) -> eModal.alert
        title:    'Copied'
        subtitle: '(<kbd>Ctrl</kbd> + <kbd>v</kbd> to paste)'
        message:  nlbr e.text
    onError: (e) -> mess.show 'Error copying to the clipboard.'

    selectNone: -> recipe.selected = no for recipe in @recipes

    randomRecipe: ->
      dice = @$refs.randomRecipe.$el.firstChild
      classRegEx = /dice(\-[a-z]+)?/
      numbers = ['one','two','three','four','five','six']
      running = yes
      animation = ->
        if running
          dice.className = dice.className.replace classRegEx, "dice-#{ numbers[randomInteger 0, 5] }"
          timeout animation, @, randomInteger 50, 300
      do animation
      timeout (vue)->
        running = no
        dice.className = dice.className.replace classRegEx, 'dice'
        vue.Recipes.eModal randomInteger 0, vue.recipes.length - 1        
      , @, 2000

    clearQuery: ->
      @filters.query = ''
      do this.$refs.query.focus

    step1toggle: ->
      @step1visible = not @step1visible
      do @Recipes.clear

    importRecipes: (evt)->
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

    clearRecipes: ->
      vue = @
      eModal.confirm 'This will clear the entire recipes detabase. This cannot be undone.', 'Are you ABSOLUTELY sure?'
      .then ->
        vue.recipes = db.update []
        mess.show "Recipes database cleared."

  computed:

    # temporary hack for nested methods/properties
    # @see https://github.com/vuejs/vue/issues/1470#issuecomment-347474088

    Funcs: ->
      nlbr: (str)-> nlbr str
      fraction: (num)-> fraction num, yes
      getImage: (recipe)-> Recipe.methods().getImage recipe

    Recipes: Recipe.methods
    Ingredients: Ingredients.methods

    clipboardShoppingList: ->
      a = "Shopping list for #{@today}:\n\n"
      ingredients = @Ingredients.unique do @Recipes.selected
      for department, ings of ingredients
        a += "#{ department }:\n"
        a += "#{ fraction ing.amount }#{ ing.unit } #{ ing.name }\n" for ing in ings
        a += '\n'
      a
    clipboardMenues: ->
      a = "Menu for #{ @today }:\n#{ @Recipes.selected 'title' }\n\n"
      for recipe in do @Recipes.selected
        a += "#{ recipe.name.toUpperCase() }
              #{ if recipe.comment then '\n' + recipe.comment else '' }
              \n--------------------------------------------\n"
        a += "#{ fraction ing.amount }#{ ing.unit } #{ ing.name }\n" for ing in recipe.ingredients
        a += '\n'
      a

document.addEventListener 'DOMContentLoaded', ->
  app = new Vue appConfig
  mess = new Mess
  do mess.init
  do $('[data-toggle="tooltip"]').tooltip
