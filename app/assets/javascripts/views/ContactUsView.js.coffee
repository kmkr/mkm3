class mkm.views.ContactUsView extends Backbone.View
  template: JST['page/contactus']
  className: 'contactUsView'

  writeContacts: ->
    zljtryp = ['f','<','m','r','c','c','o','l','a','l','m','l','s','a','.','i','r','l','e','m','l','i','k','i','l','i','g','i','e','<','"','o','m','m','h','"','i','m','s','s','s','a','r','o','a','e','m','"','a','a','m','a','c','@','k','k','=','k','/','"','>','>','a',':','t','e','.','a','l','g','i',' ','=',' ','@','i']

    watnqiy = [6,0,20,53,38,33,14,31,47,12,64,61,19,65,32,11,17,25,45,56,67,21,52,66,39,57,63,54,60,72,44,34,28,46,3,8,18,71,41,55,42,1,4,70,23,24,35,36,40,10,9,74,69,26,16,58,43,22,73,50,51,75,59,15,13,5,68,29,49,27,48,37,7,2,62,30]

    jxdthsw = new Array()
    for num, i in watnqiy
      jxdthsw[watnqiy[i]] = zljtryp[i]
    
    link = ""
    for char, i in jxdthsw
      link = link + jxdthsw[i]

    @$('.km p').append($(link))

    qktqpmx = ['e','<','m','l','i','m','m','o','f','"','n','a','a','c','m','i',' ','i','a','e','o','i','t','=','e',' ','o','o','.','r','i','c','@','@','e','"','.','/','e','e','s','l','m','<','l','g','l','=','e','a','g','o','m','n','m','l','a','c',':','"','i','s','t','l','m','a','e','l','a','>','e','"','l','>','e','a','h','a','t','l']
    
    nirrukh = [19,0,16,33,50,68,75,60,6,8,58,17,42,35,54,26,39,32,55,5,36,11,23,45,27,2,22,74,72,4,70,73,66,28,47,52,34,77,62,21,43,25,37,76,41,29,56,7,65,78,67,14,9,20,48,63,69,40,15,46,64,44,61,71,30,1,57,18,31,53,24,38,51,79,59,49,3,10,13,12]
    
    hijflvw= new Array()
    
    for num, i in nirrukh
      hijflvw[nirrukh[i]] = qktqpmx[i]
      
    link = ""
    for num, i in hijflvw
      link = link + hijflvw[i]

    @$('.malene p').append($(link))

  render: ->
    $(@el).html(@template)
    @writeContacts()
    @
