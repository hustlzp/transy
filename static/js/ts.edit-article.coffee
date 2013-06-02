# global var, use to save the item be clicked
clickItem = null

# global var, whether the data need save before leave this page
articleObj = null

# must use window.onload to adjust again
# because when document is ready, font resource hasn't been ready
# so the height of en and cn may not be precise
# but when window is ready, all resources are ready
# so the height is precise
$(window).load ->
  # init divider's height
  $('.para').each ->
    adjustHeight($(this))

$ ->
  # init divider's height
  $('.para').each ->
    adjustHeight($(this))

  # init article objects
  articleObj = buildArticleObj()

  # dynamic change divider's height
  $('.en, .cn').keyup ->
    adjustHeight($(this).parent())

  $('.en, .cn').blur ->
    adjustHeight($(this).parent())

  # adjust height when img loaded, use jquery.imageLoaded.js
  imagesLoaded($('.para')).on('progress', (instance, image)->
    adjustHeight($(image.img).parents('.para'))
  )

  # show the focus-flag when hover
  $('.para').mouseover ->
    $('.focus-flag').css('visibility', 'hidden')
    $(this).find('.focus-flag').css('visibility', 'visible')

  # toggle translate state: true or false
  $('.ec-divider').click ->
    if $(this).attr('data-state') == 'false'
      $(this).attr('data-state', 'true')
    else
      $(this).attr('data-state', 'false')      

  # save when press save button
  $('.save-btn').click(saveArticle)

  # save when press Ctrl-S
  $(document).keydown (e)->
    if e.ctrlKey and e.which == 83
      e.preventDefault()
      saveArticle()

  # alarm when window close and changes have not been saved
  $(window).on('beforeunload', ->
    if not isArticleEqual(articleObj, buildArticleObj())
      return "更改尚未保存，"
  )

  # when press tab in cn area, the next cn foucs
  $('.cn').keydown (e)->
    if e.which == 9
      e.preventDefault()
      $(this).parents('.para').next().find('.cn').focus()

  # when press Ctrl+Enter in para, switch the state of para
  $('.para').keydown (e)->
    if e.ctrlKey and e.which == 13
      divider = $(this).find('.ec-divider')
      if divider.attr('data-state') == 'false'
        divider.attr('data-state', 'true')
      else
        divider.attr('data-state', 'false')

  # handle context-menu event by delegate
  $(document).on('contextmenu', '.para', (e)->
    # prevent the browser's default context-menu
    e.preventDefault()

    # find the .para element
    if $(e.target).hasClass('para')
      clickItem = e.target
    else
      clickItem = $(e.target).parents('.para').first()[0]

    # image para should'n display 'switch type' submenu
    if $(clickItem).attr('data-type') == 'image'
      $('.context-menu').find('.only-for-text').hide()
    else
      $('.context-menu').find('.only-for-text').show()

    $('.context-menu').css
      top: e.clientY + 2 + 'px'
      left: e.clientX + 2 + 'px'
      display: 'block'
  )

  # hide context menu when click
  $(document).click ->
    $('.context-menu').hide()

  # handle context menu click
  $('.context-menu').click (e)->
    c = $(e.target).attr('class')
    switch c
      when 'mheader', 'sheader', 'text', 'quote', 'code'
        $(clickItem).attr('data-type', c)
        adjustHeight($(clickItem))
      when 'add-para'
        $(clickItem).after("<textarea class='add-content-wap' placeholder='文本 / 图片地址' rows=4></textarea>")
        # add content when textarea blur
        $('.add-content-wap').focus().blur ->
          addContent = $(this).val().trim()
          if addContent == ""
            $(this).detach()
            return
          # image
          if addContent.match(/\bhttp:\/\//) and addContent.match(/.(gif|png|jpeg|jpg|bmp)\b/)
            $(clickItem).after("""
              <div data-type='image' class='para clearfix'>
                <div class='en'>
                  <img src='#{addContent}' /></div
                ><div class='ec-divider' data-state='true'></div
                ><div class='cn'>
                  <img src='#{addContent}' />
                </div>
              </div>
            """)
            imagesLoaded($(clickItem).next(), ->
              adjustHeight($(clickItem).next())
            )
          else  # text
            $(clickItem).after("""
              <div data-type='text' class='para clearfix'>
                <div class='en' contenteditable='true'>#{addContent}</div
                ><div class='ec-divider'></div
                ><div class='cn' contenteditable='true'></div>
              </div>
            """)
            adjustHeight($(clickItem).next())

          $(this).detach()
      when 'remove-para'
        $(clickItem).detach()

###
Save article, triggle when click the save btn, or press Ctrl-S
@method saveArticle
###
saveArticle = ->
  # switch to waiting state, and show the state wap
  $('.save-state .state-waiting').show()
  $('.save-state .state-ok').hide()
  $('.save-state').animate
    right: '32px', 200
  
  # build article object
  articleObj = buildArticleObj()
  
  # post
  articleId = $('.title').data('article-id')
  $.ajax
    url: "/article/#{articleId}/edit"
    method: 'POST'
    data:
      article: articleObj
    success: (data)->
      if data.result == 1
        # switch to ok state, keep 1s, and hide the state wap
        $('.save-state .state-waiting').hide()
        $('.save-state .state-ok').show()
        setTimeout("$('.save-state').animate({right: '0px'}, 200)", 1000)


###
Whether the two object is equal
@method isArticleEqual
@param {Object} articleA - the article Object A
@param {Object} articleA - the article Object B
@return {Boolen} true means equal, false not
###
isArticleEqual = (articleA, articleB)->
  return JSON.stringify(articleA).length == JSON.stringify(articleB).length

###
Build article object from the page
@method buildArticleObj
@return {Object} the article object
###
buildArticleObj = ->
  article = 
    enTitle: $('.en-title').text().trim()
    cnTitle: $('.cn-title').text().trim()
    author: $('.author').val().trim()
    url: $('.url').val().trim()
    abstract: $('.abstract').val().trim()
    paraList: []

  $('.para').each ->
    type = $(this).attr('data-type')
    
    if type == 'image'
      en = $(this).find('.en img').attr('src')
      cn = en
    else
      en = $(this).find('.en').text().trim()
      cn = $(this).find('.cn').text().trim()

    if $(this).find('.ec-divider').attr('data-state') == 'true'
      state = true
    else
      state = false

    article.paraList.push
      en: en
      cn: cn
      type: type
      state: state

  totalChar = 0
  completeChar = 0
  for p in article.paraList 
    totalChar += p.en.length
    if p.state == true
      completeChar += p.en.length
  article.completion = Math.ceil(completeChar / totalChar * 100)

  return article

###
Dynamic change the height of the divider bar
@method adjustHeight
@param {DOM Div Element} para - the div element has class 'para'
###
adjustHeight = (para)->
  enHeight = para.find('.en').innerHeight()
  cnHeight = para.find('.cn').innerHeight()
  dvHeight = if enHeight > cnHeight then enHeight else cnHeight    
  para.find('.ec-divider').css('height', dvHeight + 15 + 'px')