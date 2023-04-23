log = (args...)->
  do console.trace
  console.log if args.length is 1 then args[0] else args

tlog = (args...)->
  do console.trace
  log args

clone = (mix)-> JSON.parse JSON.stringify mix

azsort = (arr, prop = null)->
  arr.sort (a, b)->
    if prop then a[prop].localeCompare b[prop]
    else a.localeCompare b

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

export {
  log
  tlog
  clone
  azsort
  nlbr
  parseURL
  fraction
}
