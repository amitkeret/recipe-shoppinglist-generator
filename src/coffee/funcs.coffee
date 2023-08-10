log = (args...)->
  console.log if args.length is 1 then args[0] else args

tlog = (args...)->
  do console.trace
  log args

clone = (mix)-> JSON.parse JSON.stringify mix

azsort = (arr, prop = null)->
  arr.sort (a, b)->
    if prop then a[prop].localeCompare b[prop]
    else a.localeCompare b

keysort = (object)->
  ordered = azsort Object.keys object
  if ordered.length is 0 then {}
  else
    ret = {}
    ret[key] = object[key] for key in ordered
    ret

sum = (arr, prop = null)->
  func = (s, d)-> s + d
  chain = (arr)-> arr.filter( (a)-> a? ).reduce func, 0
  if prop then chain arr.map (a)-> a[prop]
  else chain arr

nlbr = (str)->
  if str.includes '\n' then str.replaceAll '\n', '<br />'
  else str.replaceAll '<br />', '\n'

parseURL = (uri)->
  a = document.createElement 'a'
  a.href = encodeURI uri
  data =
    uri:  a.href
    host: a.hostname.replace ///^(www\.)?///, ''
    port: a.port
    css:  "url('#{a.href}')"

# convert a floating point number to a fraction
# supports mixed fractions and HTML-entity formatting
# @uses fraction.js
fraction = (decimal, html = no)->
  f = new Fraction decimal
  frac = f.toFraction true
  if html is no or f.d is 1 then frac   # d=denominator. d=1 means its a whole number
  else frac.replace(///(\d+)\/(\d+)///, '&frac$1$2;').replace(' ', '')

# basic form validator, displays error messages
# @object the object to validate
# @conditions array of arrays ( 0= prop name, 1= condition check, 2= error message )
validate = (object, conditions)->
  errors = []
  for cond in conditions
    if typeof cond[1] is 'function'
      errors.push cond[2] if cond[1](object[cond[0]]) is yes
    else
      errors.push cond[2] if object[cond[0]] is cond[1]
  mess.show errors.join "\n" if errors.length isnt 0
  errors.length is 0

randomInteger = (min, max)->
  rand = min + do Math.random * (max + 1 - min)
  Math.floor rand

# shorthand to be ablet to pass the Vue object (@) to a callback without having to re-assign it each time
# callback function accepts a single argument: (vue)->
timeout = (cb, vue, delay)-> setTimeout (-> cb(vue)), delay

export {
  log
  tlog
  clone
  azsort
  keysort
  sum
  nlbr
  parseURL
  fraction
  validate
  randomInteger
  timeout
}
