store = null
mess = null
x = null

funcs = require './funcs.coffee'

templates =
  recipe:
    name:        ''
    ingredients: []
    link:        ''
    comment:     ''
    image:       ''
  ingredient:
    name:       ''
    unit:       ''
    amount:     0
    department: ''
    optional:   no

Vue.component 'vue-multiselect', VueMultiselect.default
Vue.component 'icon', require './icon.coffee'
Vue.component 'button-icon', require './button-icon.coffee'
Vue.component 'section-title', require './section-title.coffee'
Vue.component 'recipe-item', require './recipe-item.coffee'

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
    recipe:     funcs.clone templates.recipe
    ingredient: funcs.clone templates.ingredient
    ingForm: 'exist'
    units: ['mL', 'g', 'cup(s)', 'tsp(s)', 'pack(s)']
    query: ''
    vegfilter: no
    step1visible: no

  methods:

    updateRecipeDB: (overwrite = null)->
      # 1. Backwards-compatibility: use template as starting point
      #    This is for recipes which were created prior to addition of new properties
      # 2. Multi-field ingredient sort
      #    Sorting ingredients by optional first, to push these to the end of the list
      recipes = (Object.assign funcs.clone(templates.recipe), recipe, {
        selected: no
        ingredients: recipe.ingredients.sort (a, b)-> a.optional - b.optional or a.name.localeCompare b.name
      } for recipe in overwrite ? @recipes)
      @recipes = funcs.azsort recipes, 'name'
      store.set 'recipes', @recipes

    nlbr: (str)-> funcs.nlbr str

    addIngredient: ->
      if @ingredient.name is '' then mess.show 'Ingredient name cannot be empty'
      else if @ingredient.department is '' then mess.show 'Please input department name'
      else
        @recipe.ingredients.push Object.assign @ingredient, amount: parseFloat @ingredient.amount
        do @clearIngredient

    optionalIngredient: (index)-> @recipe.ingredients[index].optional = not @recipe.ingredients[index].optional

    deleteIngredient: (index)-> @recipe.ingredients.splice index, 1

    clearIngredient: ->
      @ingredient = funcs.clone templates.ingredient
      @ingForm = 'exist'

    clearIngredientName: ->
      @ingredient.name = ''
      @ingredient.department = ''

    updateIngredientTexts: (e)->
      selected = e.target.querySelector ':checked'
      @ingredient.name = selected.value
      @ingredient.department = selected.dataset.department

    getImage: (recipe)-> if recipe.image is '' then no else funcs.parseURL recipe.image

    addRecipe: ->
      if @recipe.name is '' then mess.show 'Recipe name cannot be empty'
      else if @recipe.ingredients.length is 0 then mess.show 'Add some ingredients first'
      else
        if @editindex isnt ''
          @recipes[@editindex][prop] = @recipe[prop] for prop of @recipe when prop isnt 'selected'
          mess.show "Updated recipe: #{@recipe.name}"
        else
          @recipes.push funcs.clone @recipe
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
      @recipe = funcs.clone templates.recipe
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
      cb = -> eModal.alert app.$refs.recipePlaceholder.innerHTML, recipe.name
      # allow time for Vue to update DOM
      setTimeout(cb, 100)

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
      for d in funcs.azsort Object.keys ings
        ordered[d] = {}
        ordered[d][i] = ings[d][i] for i in funcs.azsort Object.keys ings[d]
      ordered

    onCopy: (e) -> eModal.alert
        subtitle: '(<kbd>Ctrl</kbd> + <kbd>v</kbd> to paste)'
        message: funcs.nlbr e.text
      , 'Copied'
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
        @updateRecipeDB JSON.parse e.target.result
        mess.show "#{ @recipes.length } recipes loaded successfully."
      # https://www.html5rocks.com/en/tutorials/file/dndfiles/
      reader = new FileReader
      reader.onload = onload.bind @
      reader.readAsBinaryString evt.target.files[0]

    prepareDBforDownload: (arr = @recipes)->
      funcs.clone arr
        .map (e)->
          delete e.selected
          delete e.index
    exportRecipes: ->
      records = do @prepareDBforDownload
      textToSaveAsBlob = new Blob [JSON.stringify @recipes, undefined, 2], type: 'text/json'
      downloadLink = document.createElement 'a'
      downloadLink.download = 'recipes.json'
      downloadLink.innerHTML = 'Download File'
      downloadLink.href = window.URL.createObjectURL textToSaveAsBlob
      downloadLink.onclick = (e)-> document.body.removeChild e.target
      downloadLink.style.display = 'none'
      document.body.appendChild downloadLink
      do downloadLink.click

  computed:
    selectedRecipes: -> @recipes.filter (recipe)-> recipe.selected is yes
    selectedRecipesTitle: ->
      s = @selectedRecipes.map (recipe)-> recipe.name
      s.join ', '
        .toUpperCase()

    ingredientList: -> (department: dep, ings: (name for name, details of ings) for dep, ings of do @uniqueIngredients)
    departmentList: -> Object.keys do @uniqueIngredients

    clipboardShoppingList: ->
      a = "Shopping list for #{@today}:\n\n"
      departments = @uniqueIngredients @selectedRecipes
      for department, ingredients of departments
        a += "#{department}:\n"
        a += "#{ing.amount}#{ing.unit} #{ingName}\n" for ingName, ing of ingredients
        a += '\n'
      a
    clipboardMenues: ->
      a = "Menu for #{ @today }:\n#{ @selectedRecipesTitle }\n\n"
      for recipe in @selectedRecipes
        a += "
          #{ recipe.name.toUpperCase() }
          #{ if recipe.comment then '\n' + recipe.comment else '' }
          \n--------------------------------------------\n
        "
        for ingredient in recipe.ingredients
          a += "#{ ingredient.amount }#{ ingredient.unit } #{ ingredient.name }\n"
        a += '\n'
      a

init = ->
  app = new Vue appConfig
  app.updateRecipeDB store.get 'recipes'

document.addEventListener 'DOMContentLoaded', ->
  store = new xStore 'ShoppingList', localStorage
  mess = new Mess
  do mess.init
  do init
