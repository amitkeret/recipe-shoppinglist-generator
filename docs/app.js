(()=>{var e={651:(e,n,r)=>{var t=r(631);e.exports=(t.default||t).apply(t,[])},557:(e,n,r)=>{var t=r(506);e.exports=(t.default||t).apply(t,[])},718:(e,n,r)=>{var t=r(473);e.exports=(t.default||t).apply(t,[])},440:(e,n,r)=>{var t=r(353);e.exports=(t.default||t).apply(t,[])},386:(e,n,r)=>{var t=r(641);e.exports=(t.default||t).apply(t,[])},845:(e,n,r)=>{var t=r(820);e.exports=(t.default||t).apply(t,[])},71:(e,n,r)=>{"use strict";r.d(n,{Z:()=>a});var t=r(81),i=r.n(t),o=r(645),c=r.n(o)()(i());c.push([e.id,'#app {\r\n  --transition: all 0.5s ease-in-out;\r\n}\r\n#app .clickable {\r\n  cursor: pointer;\r\n}\r\ninput[type=number] {\r\n  -moz-appearance: textfield;\r\n}\r\n.file-upload {\r\n  position: relative;\r\n  display: inline-block;\r\n}\r\n.file-upload__input {\r\n  position: absolute;\r\n  left: 0;\r\n  top: 0;\r\n  right: 0;\r\n  bottom: 0;\r\n  font-size: 1;\r\n  width:0;\r\n  height: 100%;\r\n  opacity: 0;\r\n}\r\n.file-upload__label > i {\r\n  margin-left: -0.75rem;\r\n}\r\n.recipe-image-thumbnail {\r\n  background-position: center;\r\n  background-size: cover;\r\n  box-shadow: inset 0 0 calc(1 * var(--spacer)) black;\r\n  width: 100%;\r\n  z-index: 1;\r\n}\r\n#step1 #recipeImage {\r\n  position: relative;\r\n  min-height: 7rem;\r\n}\r\n#step1 #recipeImage .recipe-image-thumbnail {\r\n  position: absolute;\r\n  height: 100%;\r\n}\r\n#step1 #recipeImage:hover > .recipe-image-thumbnail {\r\n  box-shadow: inset 0 0 calc(7 * var(--spacer)) black;\r\n  filter: grayscale(50%) blur(1px);\r\n}\r\n#step1 #recipeImage > button {\r\n  opacity: 0.8;\r\n  z-index: 2;\r\n}\r\n#step1 #recipeImage:hover > button {\r\n  opacity: 1;\r\n}\r\n#step1 #recipeImageFile {\r\n  background: none;\r\n}\r\n#step1 .recipe-form-ingredients {\r\n  position: relative;\r\n}\r\n#step1 .recipe-form-ingredients h5 {\r\n  position: absolute;\r\n  top: calc(-1 * var(--spacer));\r\n  left: calc(0.5 * var(--spacer));\r\n  padding: calc(0.25 * var(--spacer));\r\n  background: white;\r\n}\r\n#step1 #new-ingredients li .new-ing-name {\r\n  white-space: nowrap;\r\n  overflow: hidden;\r\n  text-overflow: ellipsis;\r\n}\r\n#step1 #new-ingredients li .ing-optional {\r\n  cursor: default;\r\n  opacity: 0;\r\n  transition: var(--transition);\r\n}\r\n#step1 #new-ingredients li:hover .ing-optional {\r\n  opacity: 1;\r\n}\r\n#step2 .card-header .card-header-actions {\r\n  gap: calc(0.25 * var(--spacer));\r\n}\r\n#step2 .card-header button#randomRecipe {\r\n  min-width: 2em;\r\n  overflow: hidden;\r\n}\r\n#step2 .card-body {\r\n  max-height: 60vh;\r\n  overflow-y: scroll;\r\n}\r\n#step2 .card-body table tr:first-child > td {\r\n  border-top: none;\r\n}\r\n.recipe-placeholder .recipe-image-thumbnail {\r\n  position: relative;\r\n  height: calc(10 * var(--spacer));\r\n}\r\n@media (min-width: 768px) {\r\n  .recipe-placeholder ul {\r\n    column-count: 2;\r\n    column-gap: calc(2 * var(--spacer));\r\n  }\r\n}\r\n.recipe-placeholder ul li[data-first-optional] {\r\n  margin-top: calc(0.5 * var(--spacer));\r\n  padding-top: calc(1.5 * var(--spacer));\r\n  border-top: 2px solid black;\r\n  border-image: linear-gradient(to left, transparent 2em, var(--secondary) 2em);\r\n  border-image-slice: 1;\r\n}\r\n.recipe-placeholder ul li[data-first-optional]::before {\r\n  content: "Optional:";\r\n  font-size: 80%;\r\n  position: absolute;\r\n  top: 0;\r\n}\r\n.modal .modal-title kbd {\r\n  vertical-align: text-bottom;\r\n}\r\n',""]);const a=c},40:(e,n,r)=>{"use strict";r.d(n,{Z:()=>a});var t=r(81),i=r.n(t),o=r(645),c=r.n(o)()(i());c.push([e.id,'/* Bootstrap */\r\n:root {\r\n  /* Copying Bootstrap\'s variable definition to native CSS */\r\n  --spacer: 1rem;\r\n  --form-placeholder-color: #6f7880;\r\n}\r\n.dropdown .dropdown-item {\r\n  cursor: pointer;\r\n}\r\n.transparent {\r\n  opacity: 0;\r\n}\r\n\r\n/* Mess */\r\n#mess-messElement {\r\n  position: fixed !important; /* coz the original uses "absolute" for some odd reason */\r\n  white-space: pre;           /* https://stackoverflow.com/a/33052216 */\r\n  z-index: 1500;              /* above Bootstrap, @see https://getbootstrap.com/docs/4.6/layout/overview/#z-index */\r\n}\r\n\r\n/* eModal */\r\n/* BIGFIX to support bootstrap v4\'s flexbox model */\r\n.modal .modal-header > .x.close {\r\n  order: 1;\r\n}\r\n\r\n/* vue-multiselect */\r\n.input-group .multiselect {\r\n  width: 1%;\r\n  flex: 1 1 auto;\r\n}\r\n.multiselect__placeholder {\r\n  font-size: 1rem;\r\n  margin-bottom: 0;\r\n  padding-top: 0;\r\n  color: var(--form-placeholder-color);\r\n  white-space: nowrap;\r\n  overflow: hidden;\r\n}\r\n.multiselect__tags, .multiselect__content-wrapper {\r\n  border-color: #ced4da;\r\n}\r\n.multiselect.multiselect--active .multiselect__tags {\r\n  border-color: #80bdff;\r\n  box-shadow: 0 0 0 .2rem rgba(0,123,255,.25);\r\n}\r\n.multiselect__option--group {\r\n  background: inherit !important;\r\n  color: inherit !important;\r\n  font-style: italic;\r\n  font-weight: bolder;\r\n}\r\n.multiselect__option:not(.multiselect__option--group) {\r\n  text-indent: 1rem;\r\n}\r\n\r\n/* Bootstrap-switch-button */\r\ninput[data-toggle="switchbutton"] ~ .switch-group label {\r\n  position: absolute;\r\n  padding: 0;\r\n}\r\ninput[data-toggle="switchbutton"] ~ .switch-group label.switch-on {\r\n  right: 65%;\r\n}\r\ninput[data-toggle="switchbutton"] ~ .switch-group label.switch-off {\r\n  left: 60%;\r\n}\r\n',""]);const a=c},138:(e,n,r)=>{"use strict";r.d(n,{Z:()=>a});var t=r(81),i=r.n(t),o=r(645),c=r.n(o)()(i());c.push([e.id,"tr.recipe-item {\r\n  --column: calc( 100% / 12);\r\n}\r\ntr.recipe-item > td {\r\n  vertical-align: middle;\r\n}\r\ntr.recipe-item .recipe-link {\r\n  position: relative;\r\n}\r\ntr.recipe-item .recipe-link .badge {\r\n  position: absolute;\r\n  bottom: 0;\r\n  right: 0;\r\n  transform: translateX(100%);\r\n  opacity: 0;\r\n  transition: var(--transition);\r\n}\r\ntr.recipe-item .recipe-title {\r\n  width: calc( var(--column) * 4 );\r\n}\r\ntr.recipe-item .recipe-title .recipe-link:hover .badge {\r\n  transform: translateX(calc(100% + 0.25 * var(--spacer)));\r\n  opacity: 1;\r\n}\r\ntr.recipe-item .recipe-actions {\r\n  width: calc( var(--column) * 1 );\r\n}\r\ntr.recipe-item .recipe-actions > div,\r\ntr.recipe-item .recipe-meta > div {\r\n  display: flex;\r\n  align-items: center;\r\n  justify-content: flex-end;\r\n  gap: var(--spacer);\r\n}\r\ntr.recipe-item .recipe-comment {\r\n  overflow: hidden;\r\n  text-overflow: ellipsis;\r\n}\r\ntr.recipe-item .recipe-meta {\r\n  width: calc( var(--column) * 2 );\r\n}\r\ntr.recipe-item .recipe-meta .recipe-meta-ings {\r\n  display: flex;\r\n  align-items: center;\r\n  position: relative;\r\n}\r\ntr.recipe-item .recipe-meta .recipe-meta-ings > span {\r\n  position: absolute;\r\n  right: 0;\r\n  transition: var(--transition);\r\n}\r\ntr.recipe-item .recipe-meta .recipe-meta-ings > span:nth-child(2),\r\ntr.recipe-item:hover .recipe-meta .recipe-meta-ings > span:nth-child(1) {\r\n  opacity: 0;\r\n}\r\ntr.recipe-item .recipe-meta .recipe-meta-ings > span:nth-child(1),\r\ntr.recipe-item:hover .recipe-meta .recipe-meta-ings > span:nth-child(2) {\r\n  opacity: 1;\r\n}\r\ntr.recipe-item .recipe-meta > div > .fas {\r\n  width: 16px;\r\n}\r\ntr.recipe-item .recipe-comment {\r\n  max-width: 0;\r\n}\r\ntr.recipe-item .recipe-meta-servings {\r\n  min-width: 2rem;\r\n}\r\ntr.recipe-item .recipe-meta-rating {\r\n  min-width: 1.5rem;\r\n}\r\ntr.recipe-item .recipe-rating {\r\n  display: flex;\r\n  align-items: center;\r\n}\r\ntr.recipe-item .recipe-rating > small {\r\n  font-size: 0.7rem;\r\n}\r\n",""]);const a=c},299:(e,n,r)=>{"use strict";r.d(n,{Z:()=>a});var t=r(81),i=r.n(t),o=r(645),c=r.n(o)()(i());c.push([e.id,".recipe-servings,\r\n.recipe-servings .servings-buttons {\r\n  display: flex;\r\n  align-items: center;\r\n  justify-content: end;\r\n  gap: 3px;\r\n}\r\n.recipe-servings .servings-buttons {\r\n  padding-top: 2px;\r\n  max-width: 0;\r\n  overflow: hidden;\r\n  transition: var(--transition);\r\n}\r\n.recipe-servings:hover .servings-buttons {\r\n  max-width: 5em;\r\n}\r\n.recipe-servings .servings-buttons > button {\r\n  /* Halving Bootstrap's xs size */\r\n  padding: .15rem .2rem .125rem;\r\n  font-size: 0.5rem;\r\n  line-height: 0.25;\r\n}\r\n",""]);const a=c},969:(e,n,r)=>{"use strict";r.d(n,{Z:()=>a});var t=r(81),i=r.n(t),o=r(645),c=r.n(o)()(i());c.push([e.id,".section-title {\r\n  display: inline;\r\n  cursor: pointer;\r\n}\r\n.section-title:hover {\r\n  text-decoration: underline;\r\n}\r\n",""]);const a=c},645:e=>{"use strict";e.exports=function(e){var n=[];return n.toString=function(){return this.map((function(n){var r="",t=void 0!==n[5];return n[4]&&(r+="@supports (".concat(n[4],") {")),n[2]&&(r+="@media ".concat(n[2]," {")),t&&(r+="@layer".concat(n[5].length>0?" ".concat(n[5]):""," {")),r+=e(n),t&&(r+="}"),n[2]&&(r+="}"),n[4]&&(r+="}"),r})).join("")},n.i=function(e,r,t,i,o){"string"==typeof e&&(e=[[null,e,void 0]]);var c={};if(t)for(var a=0;a<this.length;a++){var s=this[a][0];null!=s&&(c[s]=!0)}for(var l=0;l<e.length;l++){var p=[].concat(e[l]);t&&c[p[0]]||(void 0!==o&&(void 0===p[5]||(p[1]="@layer".concat(p[5].length>0?" ".concat(p[5]):""," {").concat(p[1],"}")),p[5]=o),r&&(p[2]?(p[1]="@media ".concat(p[2]," {").concat(p[1],"}"),p[2]=r):p[2]=r),i&&(p[4]?(p[1]="@supports (".concat(p[4],") {").concat(p[1],"}"),p[4]=i):p[4]="".concat(i)),n.push(p))}},n}},81:e=>{"use strict";e.exports=function(e){return e[1]}},631:(e,n,r)=>{r(55),e.exports=function(e){return""+'<div class="button-icon btn" :is="compTag" type="button" :class="compColor" @click="buttonClick"><icon v-if="icon" :icon="icon" :family="family"></icon><span v-if="text" :class="compTextClass">{{ text }}</span></div>'}},506:(e,n,r)=>{r(55),e.exports=function(e){return""+'<icon class="checkbox" :icon="icon" :family="family" :color="color" @click="$emit(\'click\')"></icon>'}},473:(e,n,r)=>{r(55),e.exports=function(e){return""+'<i :class="compClass" @click="$emit(\'click\')"></i>'}},353:(e,n,r)=>{r(55),e.exports=function(e){return""+'<tr class="recipe-item" v-show="showItem" :class="{ \'table-active\': recipe.selected }"><td class="recipe-actions"><div><div class="dropdown mt-n1"><icon class="clickable my-n2" icon="ellipsis-h" data-toggle="dropdown"></icon><div class="dropdown-menu"><div class="dropdown-item" @click="$emit(\'updaterecipe\')"><icon class="ml-n2 mr-2" icon="pen" color="warning" title="Update recipe"></icon>Edit</div><div class="dropdown-item" @click="$emit(\'deleterecipe\')"><icon class="ml-n2 mr-2" icon="trash" color="danger" title="Delete recipe"></icon>Delete</div></div></div><icon class="clickable" icon="eye" color="secondary" @click="$emit(\'emodalrecipe\')" title="View recipe"></icon></div></td><td class="recipe-title text-nowrap"><checkbox class="fa-lg mr-2" :checked="recipe.selected" @click="recipe.selected = !recipe.selected"></checkbox><div class="recipe-link" :is="recipe.link.length &gt; 0 ? \'a\' : \'span\'" :href="recipe.link.length &gt; 0 ? recipe.link : false" :target="recipe.link.length &gt; 0 ? \'_blank\' : false">{{ recipe.name }}<span v-if="recipe.link.length &gt; 0"><icon class="ml-2" icon="external-link-alt"></icon><div class="badge badge-primary">{{ getLink().host }}</div></span></div></td><td class="recipe-comment text-nowrap"><i v-if="recipe.comment.length &gt; 0">{{ recipe.comment }}</i></td><td class="recipe-meta"><div><div class="recipe-meta-ings" v-if="ingSearch.length &gt; 0"><span class="badge badge-pill" :class="ingSearch.length == filters.ings.length ? \'badge-primary\' : \'badge-secondary\'">{{ ingSearch.length }}</span><span class="text-nowrap"><div class="ml-1 badge badge-pill badge-primary" v-for="ing in ingSearch">{{ ing.name }}</div></span></div><div class="recipe-meta-servings"><recipe-servings :recipe="recipe"></recipe-servings></div><div class="recipe-meta-rating"><div class="recipe-rating" v-if="recipe.rating"><icon class="fa-sm" icon="star" color="warning"></icon><small>{{ recipe.rating }}</small></div></div><icon :icon="isVeg ? \'leaf\' : \'drumstick-bite\'" :color="isVeg ? \'success\' : \'danger\'"></icon></div></td></tr>'}},641:(e,n,r)=>{r(55),e.exports=function(e){return""+'<div class="recipe-servings" v-if="recipe.servings"><span class="text-nowrap" :class="{ \'text-danger font-weight-bold\': currentServings !== recipe.servings }"><icon class="mr-1" icon="utensils"></icon><span>{{ currentServings | 0 }}</span></span><span class="servings-buttons"><button-icon class="btn-xs rounded-circle" v-for="dir, index in [\'plus\', \'minus\']" :icon="dir" color="dark" @click="update(index ? -1 : 1)"></button-icon></span></div>'}},820:(e,n,r)=>{r(55),e.exports=function(e){return""+'<h4 class="section-title" @click.stop="$emit(\'click\')"><span class="badge badge-dark rounded-circle mr-2"><span v-if="text">{{ text }}</span><icon v-if="icon" :icon="icon" :family="family"></icon></span>{{ title }}</h4>'}},55:(e,n,r)=>{"use strict";var t=Object.prototype.hasOwnProperty;function i(e,n){return Array.isArray(e)?function(e,n){for(var r,t="",o="",c=Array.isArray(n),a=0;a<e.length;a++)(r=i(e[a]))&&(c&&n[a]&&(r=s(r)),t=t+o+r,o=" ");return t}(e,n):e&&"object"==typeof e?function(e){var n="",r="";for(var i in e)i&&e[i]&&t.call(e,i)&&(n=n+r+i,r=" ");return n}(e):e||""}function o(e){if(!e)return"";if("object"==typeof e){var n="";for(var r in e)t.call(e,r)&&(n=n+r+":"+e[r]+";");return n}return e+""}function c(e,n,r,t){if(!1===n||null==n||!n&&("class"===e||"style"===e))return"";if(!0===n)return" "+(t?e:e+'="'+e+'"');var i=typeof n;return"object"!==i&&"function"!==i||"function"!=typeof n.toJSON||(n=n.toJSON()),"string"==typeof n||(n=JSON.stringify(n),r||-1===n.indexOf('"'))?(r&&(n=s(n))," "+e+'="'+n+'"'):" "+e+"='"+n.replace(/'/g,"&#39;")+"'"}n.merge=function e(n,r){if(1===arguments.length){for(var t=n[0],i=1;i<n.length;i++)t=e(t,n[i]);return t}for(var c in r)if("class"===c){var a=n[c]||[];n[c]=(Array.isArray(a)?a:[a]).concat(r[c]||[])}else if("style"===c){a=(a=o(n[c]))&&";"!==a[a.length-1]?a+";":a;var s=o(r[c]);s=s&&";"!==s[s.length-1]?s+";":s,n[c]=a+s}else n[c]=r[c];return n},n.classes=i,n.style=o,n.attr=c,n.attrs=function(e,n){var r="";for(var a in e)if(t.call(e,a)){var s=e[a];if("class"===a){r=c(a,s=i(s),!1,n)+r;continue}"style"===a&&(s=o(s)),r+=c(a,s,!1,n)}return r};var a=/["&<>]/;function s(e){var n=""+e,r=a.exec(n);if(!r)return e;var t,i,o,c="";for(t=r.index,i=0;t<n.length;t++){switch(n.charCodeAt(t)){case 34:o="&quot;";break;case 38:o="&amp;";break;case 60:o="&lt;";break;case 62:o="&gt;";break;default:continue}i!==t&&(c+=n.substring(i,t)),i=t+1,c+=o}return i!==t?c+n.substring(i,t):c}n.escape=s,n.rethrow=function e(n,t,i,o){if(!(n instanceof Error))throw n;if(!("undefined"==typeof window&&t||o))throw n.message+=" on line "+i,n;try{o=o||r(835).readFileSync(t,"utf8")}catch(r){e(n,null,i)}var c=3,a=o.split("\n"),s=Math.max(i-c,0),l=Math.min(a.length,i+c);throw c=a.slice(s,l).map((function(e,n){var r=n+s+1;return(r==i?"  > ":"    ")+r+"| "+e})).join("\n"),n.path=t,n.message=(t||"Pug")+":"+i+"\n"+c+"\n\n"+n.message,n}},379:e=>{"use strict";var n=[];function r(e){for(var r=-1,t=0;t<n.length;t++)if(n[t].identifier===e){r=t;break}return r}function t(e,t){for(var o={},c=[],a=0;a<e.length;a++){var s=e[a],l=t.base?s[0]+t.base:s[0],p=o[l]||0,u="".concat(l," ").concat(p);o[l]=p+1;var d=r(u),m={css:s[1],media:s[2],sourceMap:s[3],supports:s[4],layer:s[5]};if(-1!==d)n[d].references++,n[d].updater(m);else{var f=i(m,t);t.byIndex=a,n.splice(a,0,{identifier:u,updater:f,references:1})}c.push(u)}return c}function i(e,n){var r=n.domAPI(n);return r.update(e),function(n){if(n){if(n.css===e.css&&n.media===e.media&&n.sourceMap===e.sourceMap&&n.supports===e.supports&&n.layer===e.layer)return;r.update(e=n)}else r.remove()}}e.exports=function(e,i){var o=t(e=e||[],i=i||{});return function(e){e=e||[];for(var c=0;c<o.length;c++){var a=r(o[c]);n[a].references--}for(var s=t(e,i),l=0;l<o.length;l++){var p=r(o[l]);0===n[p].references&&(n[p].updater(),n.splice(p,1))}o=s}}},569:e=>{"use strict";var n={};e.exports=function(e,r){var t=function(e){if(void 0===n[e]){var r=document.querySelector(e);if(window.HTMLIFrameElement&&r instanceof window.HTMLIFrameElement)try{r=r.contentDocument.head}catch(e){r=null}n[e]=r}return n[e]}(e);if(!t)throw new Error("Couldn't find a style target. This probably means that the value for the 'insert' parameter is invalid.");t.appendChild(r)}},216:e=>{"use strict";e.exports=function(e){var n=document.createElement("style");return e.setAttributes(n,e.attributes),e.insert(n,e.options),n}},565:(e,n,r)=>{"use strict";e.exports=function(e){var n=r.nc;n&&e.setAttribute("nonce",n)}},795:e=>{"use strict";e.exports=function(e){if("undefined"==typeof document)return{update:function(){},remove:function(){}};var n=e.insertStyleElement(e);return{update:function(r){!function(e,n,r){var t="";r.supports&&(t+="@supports (".concat(r.supports,") {")),r.media&&(t+="@media ".concat(r.media," {"));var i=void 0!==r.layer;i&&(t+="@layer".concat(r.layer.length>0?" ".concat(r.layer):""," {")),t+=r.css,i&&(t+="}"),r.media&&(t+="}"),r.supports&&(t+="}");var o=r.sourceMap;o&&"undefined"!=typeof btoa&&(t+="\n/*# sourceMappingURL=data:application/json;base64,".concat(btoa(unescape(encodeURIComponent(JSON.stringify(o))))," */")),n.styleTagTransform(t,e,n.options)}(n,e,r)},remove:function(){!function(e){if(null===e.parentNode)return!1;e.parentNode.removeChild(e)}(n)}}}},589:e=>{"use strict";e.exports=function(e,n){if(n.styleSheet)n.styleSheet.cssText=e;else{for(;n.firstChild;)n.removeChild(n.firstChild);n.appendChild(document.createTextNode(e))}}},835:()=>{}},n={};function r(t){var i=n[t];if(void 0!==i)return i.exports;var o=n[t]={id:t,exports:{}};return e[t](o,o.exports,r),o.exports}r.n=e=>{var n=e&&e.__esModule?()=>e.default:()=>e;return r.d(n,{a:n}),n},r.d=(e,n)=>{for(var t in n)r.o(n,t)&&!r.o(e,t)&&Object.defineProperty(e,t,{enumerable:!0,get:n[t]})},r.o=(e,n)=>Object.prototype.hasOwnProperty.call(e,n),r.nc=void 0,(()=>{"use strict";var e=r(379),n=r.n(e),t=r(795),i=r.n(t),o=r(569),c=r.n(o),a=r(565),s=r.n(a),l=r(216),p=r.n(l),u=r(589),d=r.n(u),m=r(71),f={};f.styleTagTransform=d(),f.setAttributes=s(),f.insert=c().bind(null,"head"),f.domAPI=i(),f.insertStyleElement=p(),n()(m.Z,f),m.Z&&m.Z.locals&&m.Z.locals;var g,h,v,b,y,w,x,k,S,I,A,R,C,M,O,T,N=r(40),Z={};Z.styleTagTransform=d(),Z.setAttributes=s(),Z.insert=c().bind(null,"head"),Z.domAPI=i(),Z.insertStyleElement=p(),n()(N.Z,Z),N.Z&&N.Z.locals&&N.Z.locals,h=function(e){return JSON.parse(JSON.stringify(e))},g=function(e,n=null){return e.sort((function(e,r){return n?e[n].localeCompare(r[n]):e.localeCompare(r)}))},b=function(e){var n,r,t,i,o;if(0===(i=g(Object.keys(e))).length)return{};for(o={},n=0,t=i.length;n<t;n++)o[r=i[n]]=e[r];return o},y=function(e){var n,r,t,i,o;if(Array.isArray(e)){for(t=r=0,i=e.length;r<i;t=++r)n=e[t],e[t]=y(n);return e}if(null===e)return e;if("object"==typeof e){for(o in e)n=e[o],e[o]=y(n);return b(e)}return e},S=function(e,n=null){var r,t;return t=function(e,n){return e+n},r=function(e){return e.filter((function(e){return null!=e})).reduce(t,0)},r(n?e.map((function(e){return e[n]})):e)},w=function(e){return e.includes("\n")?e.replaceAll("\n","<br />"):e.replaceAll("<br />","\n")},x=function(e){var n;return(n=document.createElement("a")).href=encodeURI(e),{uri:n.href,host:n.hostname.replace(/^(www\.)?/,""),port:n.port,css:`url('${n.href}')`}},v=function(e,n=!1){var r,t;return t=(r=new Fraction(e)).toFraction(!0),!1===n||1===r.d?t:t.replace(/(\d+)\/(\d+)/,"&frac$1$2;").replace(" ","")},A=function(e,n){var r,t,i,o;for(t=[],i=0,o=n.length;i<o;i++)"function"==typeof(r=n[i])[1]?!0===r[1](e[r[0]])&&t.push(r[2]):e[r[0]]===r[1]&&t.push(r[2]);return 0!==t.length&&mess.show(t.join("\n")),0===t.length},k=function(e,n){var r;return r=e+Math.random()*(n+1-e),Math.floor(r)},I=function(e,n,r){return setTimeout((function(){return e(n)}),r)},C={recipe:{name:"",link:"",comment:"",image:"",servings:null,rating:null,ingredients:[]},ingredient:{name:"",department:"",amount:0,unit:null,optional:!1}},M=function(){return T.set("recipes",[])},(O={JSON:[{name:"name"},{name:"link"},{name:"comment"},{name:"image"},{name:"servings",formatFunc:function(e){return parseInt(0|e)}},{name:"rating",formatFunc:function(e){return parseInt(0|e)}},{name:"ingredients",init:[],formatFunc:function(e){var n,r,t;for(n=0,t=e.length;n<t;n++)(r=e[n]).amount=parseFloat(r.amount);return e.sort((function(e,n){return e.optional-n.optional||e.name.localeCompare(n.name)}))}}]}).Vue=O.JSON.concat([{name:"selected",init:!1},{name:"servingsModifier",init:1}]),R=function(e=[],n="JSON"){var r,t,i,o,c,a,s,l,p,u,d,m,f,v,b,w;for(Array.isArray(e)||(e=[e]),e=h(e),t=O[n].map((function(e){return e.name})),i=0,s=e.length;i<s;i++)for(f in v=e[i])t.includes(f)||delete v[f];for(o=0,l=e.length;o<l;o++)for(v=e[o],c=0,p=(b=O[n]).length;c<p;c++)null!=(r=b[c]).init&&null==v[r.name]&&(v[r.name]=r.init);for(a=0,u=e.length;a<u;a++)for(v=e[a],m=0,d=(w=O[n]).length;m<d;m++)null!=(r=w[m]).formatFunc&&(v[r.name]=r.formatFunc(v[r.name]));return 1===(e=g(y(e),"name")).length?e[0]:e},(T=new xStore("ShoppingList_",localStorage)).get("recipes")||M(),T.convert=R,T.getAll=function(){return R(T.get("recipes"),"Vue")},T.importJSON=function(e){return T.update(JSON.parse(e))},T.exportJSON=function(){return R(T.get("recipes"),"JSON")},T.update=function(e){var n;return n=R(e,"Vue"),T.set("recipes",n),n};var j,_=r(969),L={};L.styleTagTransform=d(),L.setAttributes=s(),L.insert=c().bind(null,"head"),L.domAPI=i(),L.insertStyleElement=p(),n()(_.Z,L),_.Z&&_.Z.locals&&_.Z.locals,j={props:["title","text","icon","family"],template:r(845)};var E,F=r(299),J={};J.styleTagTransform=d(),J.setAttributes=s(),J.insert=c().bind(null,"head"),J.domAPI=i(),J.insertStyleElement=p(),n()(F.Z,J),F.Z&&F.Z.locals&&F.Z.locals,E={props:["recipe"],computed:{currentServings:function(){return this.recipe.servings*this.recipe.servingsModifier}},methods:{update:function(e){if(this.currentServings+e!==0)return this.recipe.servingsModifier=(this.currentServings+e)/this.recipe.servings}},template:r(386)};var z,V,q,B,D,P,U,H,X,W,G,Q,Y,K,ee=r(138),ne={};ne.styleTagTransform=d(),ne.setAttributes=s(),ne.insert=c().bind(null,"head"),ne.domAPI=i(),ne.insertStyleElement=p(),n()(ee.Z,ne),ee.Z&&ee.Z.locals&&ee.Z.locals,V={recipe:h(C.recipe),activeRecipe:null},q=function(){var e;return e=this,{setActive:function(n){return e.Recipe.activeRecipe=e.recipes[n]},clear:function(){return e.Recipe.recipe=h(C.recipe),e.Ingredients.clear(),e.editindex>-1&&(e.step1visible=!1),e.editindex=-1},save:function(){var n,r;if(n=[["name","","Recipe name: Cannot be empty"],["ingredients",function(e){return 0===e.length},"Ingredients: Add at least one ingredient"],["servings",function(e){return e%1!=0},"Servings: Whole numbers only (1-10)"],["rating",function(e){return e%1!=0},"Rating: Whole numbers only (1-5)"]],A(e.Recipe.recipe,n))return r=T.convert(e.Recipe.recipe,"Vue"),e.editindex>-1?(e.recipes[e.editindex]=r,e.step1visible=!1):e.recipes.push(r),mess.show(`${e.editindex>-1?"Updated":"Added new"} recipe: ${e.Recipe.recipe.name}`),e.Recipes.clear(),T.update(e.recipes)},delete:function(n){return eModal.confirm("This cannot be undone.","Are you sure?").then((function(){return e.recipes.splice(n,1),T.update(e.recipes)}))},update:function(n){return e.Recipe.recipe=h(e.recipes[n]),e.editindex=n,e.step1visible=!0},eModal:function(n){return e.Recipes.setActive(n),e.step1visible=!1,setTimeout((function(){return eModal.alert({title:e.Recipe.activeRecipe.name,subtitle:e.$refs.recipePlaceholderLink.outerHTML,message:e.$refs.recipePlaceholder.outerHTML})}),100)},selected:function(n=null){var r,t;switch(t=function(){var n,t,i,o;for(o=[],n=0,t=(i=e.recipes).length;n<t;n++)!0===(r=i[n]).selected&&o.push(r);return o}(),n){case"title":return function(){var e,n,i;for(i=[],e=0,n=t.length;e<n;e++)r=t[e],i.push(r.name);return i}().join(", ").toUpperCase();case"servings":return S(function(){var e,n,i;for(i=[],e=0,n=t.length;e<n;e++)r=t[e],i.push(r.servings*r.servingsModifier);return i}());default:return t}}}},z={components:{"recipe-servings":E},props:["recipe","filters"],created:function(){},updated:function(){},methods:{getLink:function(){return 0!==this.recipe.link.length&&x(this.recipe.link)}},computed:{ingSearch:function(){var e,n;return e=function(){var e,r,t,i;for(i=[],e=0,r=(t=this.filters.ings).length;e<r;e++)n=t[e],i.push(n.name);return i}.call(this),function(){var r,t,i,o;for(o=[],r=0,t=(i=this.recipe.ingredients).length;r<t;r++)n=i[r],e.includes(n.name)&&o.push(n);return o}.call(this)},showIngs:function(){var e;return e=!0,0!==this.filters.ings.length&&(e=!0===this.filters.ingModeAnd?this.ingSearch.length===this.filters.ings.length:this.ingSearch.length>0),e},isVeg:function(){var e;return 0===function(){var n,r,t,i;for(i=[],n=0,r=(t=this.recipe.ingredients).length;n<r;n++)"Meats"===(e=t[n]).department&&i.push(e);return i}.call(this).length},showItem:function(){var e,n;return n={AND:{veg:!1===this.filters.veg||!0===this.isVeg,ings:this.showIngs},OR:{empty:0===this.filters.query.length,title:this.recipe.name.toLowerCase().includes(this.filters.query),comment:this.recipe.comment.toLowerCase().includes(this.filters.query)}},e=Object.values(n.AND).every((function(e){return!0===e})),!0===Object.values(n.OR).includes(!0)&&!0===e}},template:r(440)},B={ingredient:h(C.ingredient),units:["","mL","g"," cup(s)"," tbsp(s)"," tsp(s)"," pack(s)"],ingForm:"exist"},P=function(e,n=!0){var r,t,i,o,c,a,s,l,p,u,d;for(c={},i=0,s=e.length;i<s;i++)for(a=0,l=(d=(u=e[i]).ingredients).length;a<l;a++)c[(o=d[a]).department]||(c[o.department]={}),c[o.department][o.name]?c[o.department][o.name].amount+=o.amount:c[o.department][o.name]={name:o.name,unit:o.unit,amount:o.amount*u.servingsModifier,department:o.department};for(r in c)o=c[r],c[r]=g(function(){var e;for(p in e=[],o)t=o[p],e.push(t);return e}(),"name");return!0===n?b(c):g(Object.values(c).flat(),"name")},D=function(){var e;return e=this,{unique:P,clear:function(n="exist"){return e.Ingredient.ingredient=h(C.ingredient),e.Ingredient.ingForm=n},add:function(){var n;if(n=[["name","","Ingredient name: Cannot be empty"],["department","","Department name: Cannot be empty"],["amount",function(e){return""===e||!0===isNaN(e)||e<.25||8*e%1!=0},"Amount: Decimal numbers in steps of 0.25"],["unit",null,"Unit: Selection required"]],A(e.Ingredient.ingredient,n))return null!=e.Ingredient.ingredient.name.name&&(e.Ingredient.ingredient.name=e.Ingredient.ingredient.name.name),e.Recipe.recipe.ingredients.push(e.Ingredient.ingredient),e.Ingredients.clear()},updateExisting:function(n){return e.Ingredient.ingredient.department=n.department,e.Ingredient.ingredient.unit=n.unit},optional:function(n){return e.Recipe.recipe.ingredients[n].optional=!e.Recipe.recipe.ingredients[n].optional},delete:function(n){return e.Recipe.recipe.ingredients.splice(n,1)},list:function(){var n,r,t,i,o,c;for(n in c=[],o=P(e.recipes))t=o[n],c.push({department:n,ings:function(){var e;for(i in e=[],t)r=t[i],e.push(r);return e}()});return c},listFlat:function(){return P(e.recipes,!1)},departments:function(){return Object.keys(P(e.recipes))}}},Y=r(718),X=r(651),G=r(557),Q={props:U=["icon","color","family"],methods:{getStyle:function(){var e;return null!=(e=this.family)?e:"fas"}},computed:{compIcon:function(){return`${this.getStyle()} fa-${this.icon}`},compColor:function(){return this.color?`text-${this.color}`:""},compClass:function(){return`${this.compIcon} ${this.compColor}`}},template:Y},H={props:U.concat(["tag","text","textBreakpoint"]),methods:{buttonClick:function(){return this.$emit("click"),this.$el.blur()}},computed:{compColor:function(){return this.color?`btn-${this.color}`:"btn-secondary"},compTag:function(){var e;return null!=(e=this.tag)?e:"button"},children:function(){var e;return function(){var n,r,t,i;for(i=[],n=0,r=(t=[this.icon,this.text]).length;n<r;n++)null!=(e=t[n])&&i.push(e);return i}.call(this).length},compTextClass:function(){return[null!=this.textBreakpoint?`d-none d-${this.textBreakpoint}-inline`:"",this.children>1?"ml-2":""].join(" ")}},template:X},W={props:["checked"],computed:{icon:function(){return this.checked?"check-square":"square"},family:function(){return this.checked?"fas":"far"},color:function(){return this.checked?"primary":""}},template:G},Vue.component("icon",Q),Vue.component("button-icon",H),Vue.component("checkbox",W),K={el:"#app",components:{"section-title":j,"vue-multiselect":VueMultiselect.default,"recipe-item":z},data:function(){return{recipes:[],editindex:-1,today:(new Date).toLocaleDateString("en-AU",{weekday:"short",year:"numeric",month:"long",day:"numeric"}),Recipe:V,Ingredient:B,filters:{query:"",ings:[],ingModeAnd:!1,veg:!1},step1visible:!1}},created:function(){return this.recipes=T.getAll()},methods:{onCopy:function(e){return eModal.alert({title:"Copied",subtitle:"(<kbd>Ctrl</kbd> + <kbd>v</kbd> to paste)",message:w(e.text)})},onError:function(e){return mess.show("Error copying to the clipboard.")},selectNone:function(){var e,n,r,t,i;for(i=[],e=0,n=(t=this.recipes).length;e<n;e++)r=t[e],i.push(r.selected=!1);return i},randomRecipe:function(){var e,n,r,t,i;return r=this.$refs.randomRecipe.$el.firstChild,n=/dice(\-[a-z]+)?/,t=["one","two","three","four","five","six"],i=!0,(e=function(){if(i)return r.className=r.className.replace(n,`dice-${t[k(0,5)]}`),I(e,this,k(50,300))})(),I((function(e){return i=!1,r.className=r.className.replace(n,"dice"),e.Recipes.eModal(k(0,e.recipes.length-1))}),this,2e3)},clearQuery:function(){return this.filters.query="",this.$refs.query.focus()},step1toggle:function(){return this.step1visible=!this.step1visible,this.Recipes.clear()},importRecipes:function(e){var n,r;return n=function(e){var n;return n=(new TextDecoder).decode(e.target.result),this.recipes=T.importJSON(n),mess.show(`${this.recipes.length} recipes loaded successfully.`)},(r=new FileReader).onloadend=n.bind(this),r.readAsArrayBuffer(e.target.files[0])},exportRecipes:function(){var e,n,r;return n=JSON.stringify(T.exportJSON(),void 0,2),r=new Blob([n],{type:"text/json"}),e=document.createElement("a"),Object.assign(e,{download:"recipes.json",innerHTML:"Download File",href:window.URL.createObjectURL(r),onclick:function(e){return document.body.removeChild(e.target)}}),e.style.display="none",document.body.appendChild(e),e.click()},clearRecipes:function(){var e;return e=this,eModal.confirm("This will clear the entire recipes detabase. This cannot be undone.","Are you ABSOLUTELY sure?").then((function(){return e.recipes=T.update([]),mess.show("Recipes database cleared.")}))}},computed:{Funcs:function(){return{nlbr:function(e){return w(e)},fraction:function(e){return v(e,!0)},getImage:function(e){return""!==e.image&&x(e.image)}}},Recipes:q,Ingredients:D,clipboardShoppingList:function(){var e,n,r,t,i,o,c;for(n in e=`Shopping list for ${this.today}:\n\n`,i=this.Ingredients.unique(this.Recipes.selected())){for(e+=`${n}:\n`,r=0,c=(o=i[n]).length;r<c;r++)t=o[r],e+=`${v(t.amount)}${t.unit} ${t.name}\n`;e+="\n"}return e},clipboardMenues:function(){var e,n,r,t,i,o,c,a,s;for(e=`Menu for ${this.today}:\n${this.Recipes.selected("title")}\n\n`,n=0,i=(a=this.Recipes.selected()).length;n<i;n++){for(e+=`${(c=a[n]).name.toUpperCase()} ${c.comment?"\n"+c.comment:""} \n--------------------------------------------\n`,t=0,o=(s=c.ingredients).length;t<o;t++)r=s[t],e+=`${v(r.amount)}${r.unit} ${r.name}\n`;e+="\n"}return e}}},document.addEventListener("DOMContentLoaded",(function(){return new Vue(K),(new Mess).init(),$('[data-toggle="tooltip"]').tooltip()}))})()})();