module.exports =

  clog: (args...)->
    do console.trace
    console.log args

  clone: (mix)-> JSON.parse JSON.stringify mix

  azsort: (arr, prop = null)->
    arr.sort (a, b)->
      if prop then a[prop].localeCompare b[prop]
      else a.localeCompare b

  nlbr: (str)->
    if str.includes '\n' then str.replaceAll '\n', '<br />'
    else str.replaceAll '<br />', '\n'

  parseURL: (uri)->
    a = document.createElement 'a'
    a.href = encodeURI uri
    data =
      uri:  a.href
      host: a.hostname.replace ///^(www\.)?///, ''
      port: a.port
      css:  "url('#{a.href}')"
