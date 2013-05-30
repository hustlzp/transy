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
    article.paraList.push
      en: $(this).find('.en').text().trim()
      cn: $(this).find('.cn').text().trim()
      type: $(this).data('type')
      state: false

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
###
adjustHeight = (para)->
  enHeight = para.find('.en').height()
  cnHeight = para.find('.cn').height()
  dvHeight = if enHeight > cnHeight then enHeight else cnHeight    
  para.find('.ec-divider').css
    height: dvHeight + 15 + 'px' 

$ ->
  $('.para').each ->
    adjustHeight($(this))

  # dynamic change the height of divider
  $('.en, .cn').keyup ->
    adjustHeight($(this).parent())

  # save when press save button
  $('.btn-save').click(saveArticle)

  # save when press Ctrl-S
  # todo
  
  # global var, save the item be clicked
  clickItem = null
  classList = "type-mheader type-sheader type-text type-quote type-code"

  # context menu handle
  $('.para').each ->
    $(this)[0].oncontextmenu = (e)->
      # pass target to global var
      clickItem = $(e.target).parents('.para').first()[0]

      # prevent the browser's context menu
      e.preventDefault()

      $('.context-menu').css
        top: e.clientY + 2 + 'px'
        left: e.clientX + 2 + 'px'
        display: 'block'

  # context menu hide when click
  $(document).click ->
    $('.context-menu').hide()

  $('.context-menu').click (e)->
    c = $(e.target).attr('class')
    switch c
      when 'mheader', 'sheader', 'text', 'quote', 'code'
        $(clickItem).removeClass(classList).addClass("type-#{c}")
        $(clickItem).attr('data-type', c)
      when 'add-para'
        # $(clickItem).after("<div class='add-content-wap' contenteditable=true></div>")
        $(clickItem).after("<textarea class='add-content-wap' rows=5></textarea>")
        $('.add-content-wap').focus().blur ->
          addContent = $(this).val().split('\n')
          html = ""
          for a in addContent when a != ""
            html += """<div data-type='text' class='para type-text'>
                <div class='en' contenteditable=true>#{a}</div
                ><div class='ec-divider'></div
                ><div class='cn' contenteditable=true></div>
              </div>"""
          $(clickItem).after(html)
          $(this).detach()

          # ajust height
          adjustHeight($(clickItem).next())
      when 'remove-para'
        $(clickItem).detach()
