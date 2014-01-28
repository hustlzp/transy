$(function(){
    // delete confirm
    $('.btn-delete').click(function(){
        return confirm('确认删除此文章？');
    });

    // display mode: ec, cn, en
    var mode = 'ec';
    var id = $('.cn-title').data('article-id');

    $('.btn-sel-ec').click(function(){
        $('.en').show();
        $('.cn').show();
        mode = 'ec';
    });

    $('.btn-sel-en').click(function(){
        $('.en').show();
        $('.cn').hide();
        mode = 'en';
    });

    $('.btn-sel-cn').click(function(){
        $('.en').hide();
        $('.cn').show();
        mode = 'cn';
    });
});