$(function(){
  var clickItem;

  $('.para-list').each(function(){
    // the para item's height
    var pHeight = $(this).height();
    
    $(this).find('.cn').css('height', pHeight + 'px');
    $(this).find('.ec-divider').css('height', pHeight + 'px');
  });

  $('.btn-save').click(function(){
    // build article object
    var article = {
      enTitle: $('.en-title').text(),
      cnTitle: $('.cn-title').text(),
      url: $('.url').text(),
      abstract: $('.abstract').text(),
      paraList: []
    };

    $('.para-list').each(function(){
      article.paraList.push({
        en: $(this).find('.en').text().trim(),
        cn: $(this).find('.cn').text().trim(),
        type: 'para',
        state: false
      });
    });

    articleId = $('.title').data('article-id');

    // post
    $.ajax({
      url: '/article/'+ articleId + '/edit',
      method: 'POST',
      data: {
        article: article
      },
      success: function(data){
        if(data.result === 1){
          alert('saved');
        }
      }
    });
  });

  // add context menu handle
  $('.para-list').each(function(){
    $(this)[0].oncontextmenu = function(e){
      e.preventDefault();
      clickItem = e.target;

      $('.context-menu').css({
        top: e.clientY + 2 + 'px',
        left: e.clientX + 2 + 'px',
        display: 'block'
      });
    }
  });

  $(document).click(function(){
    $('.context-menu').hide();
  });
});