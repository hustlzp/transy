###
Save article, triggle when click the save btn, or press Ctrl-S
###

saveArticle = ->
  # build article object
  article = 
    enTitle: $('.en-title').text()
    cnTitle: $('.cn-title').text()
    url: $('.url').text()
    abstract: $('.abstract').text()
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

  # compute completion
  completeNum = 0
  for p in article.paraList when p.state == true
    completeNum++
  article.completion = (completeNum / article.paraList.length).toFixed(2)

  # post
  articleId = $('.title').data('article-id')
  $.ajax
    url: "/article/#{articleId}/edit"
    method: 'POST'
    data:
      article: article
    success: (data)->
      if data.result == 1
        alert('saved')


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

$ ->
  # init divider's height
  $('.para').each ->
    adjustHeight($(this))

  # dynamic change divider's height
  $('.en, .cn').keyup ->
    adjustHeight($(this).parent())

  $('.en, .cn').blur ->
    adjustHeight($(this).parent())

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
  $('.btn-save').click(saveArticle)

  # save when press Ctrl-S
  # todo
  
  # global var, save the item be clicked
  clickItem = null

  # handle context menu event by delegate
  $(document).on('contextmenu', '.para', (e)->
    # find the .para element
    if $(e.target).hasClass('para')
      clickItem = e.target
    else
      clickItem = $(e.target).parents('.para').first()[0]

    if $(clickItem).attr('data-type') == 'image'
      $('.context-menu').find('.only-for-text').hide()
    else
      $('.context-menu').find('.only-for-text').show()

    # prevent the browser's context menu
    e.preventDefault()

    $('.context-menu').css
      top: e.clientY + 2 + 'px'
      left: e.clientX + 2 + 'px'
      display: 'block'
  )

  # context menu hide when click
  $(document).click ->
    $('.context-menu').hide()

  $('.context-menu').click (e)->
    c = $(e.target).attr('class')
    switch c
      when 'mheader', 'sheader', 'text', 'quote', 'code'
        $(clickItem).attr('data-type', c)
        # ajust height
        adjustHeight($(clickItem))
      when 'add-para'
        # $(clickItem).after("<div class='add-content-wap' contenteditable=true></div>")
        $(clickItem).after("<textarea class='add-content-wap' placeholder='文本、图片地址' rows=4></textarea>")
        $('.add-content-wap').focus().blur ->
          # addContent = $(this).val().replace(/\n+/g, '<br>')
          addContent = $(this).val().trim()
          if addContent != ""
            # image
            if addContent.match(/\b(http:\/\/)/) and addContent.match(/.(gif|png|jpeg|jpg|bmp)\b/)
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
            # text
            else
              $(clickItem).after("""
                <div data-type='text' class='para clearfix'>
                  <div class='en' contenteditable='true'>#{addContent}</div
                  ><div class='ec-divider'></div
                  ><div class='cn' contenteditable='true'></div>
                </div>
              """)
              adjustHeight($(clickItem).next())

          # close textarea
          $(this).detach()
        # $('.add-content-wap').focus().blur ->
        #   addContent = $(this).val().split('\n')
        #   now = $(clickItem)
        #   for a in addContent when a != ""
        #     now.after("""<div data-type='text' class='para type-text'>
        #         <div class='en' contenteditable=true>#{a}</div
        #         ><div class='ec-divider'></div
        #         ><div class='cn' contenteditable=true></div>
        #       </div>""")
        #     adjustHeight(now.next())
        #     now = now.next()
        #   $(this).detach()

          # ajust height
          adjustHeight($(clickItem).next())
      when 'remove-para'
        $(clickItem).detach()
