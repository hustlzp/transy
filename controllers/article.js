
/*
 * Article related
 */

var Article = require('../models/article');

exports.article = function(req, res){
  Article.findById(req.params.id, function(err, data){
    res.render("article/article", { 
      title: 'Article',
      page: 'page-article',
      article: data 
    });
  });
};

exports.showAdd = function(req, res){
  res.render('article/add_article', {
    title: 'Add article',
    page: 'page-add-article'
  });
};

exports.add = function(req, res){
  var article = new Article({
    enTitle: req.body.title,
    url: req.body.url,
    completion: 0,
    createTime: new Date(),
    updateTime: new Date(),
    paraList: []
  });

  // process the paragraph
  var paraList = [];
  paras = req.body.content.split('\n');
  for(var i=0; i<paras.length; i++){
    paras[i] = paras[i].trim();
    if(paras[i].length == 0){
      continue;
    }

    article.paraList.push({
      en: paras[i],
      cn: '',
      type: 'text',
      state: false
    });
  }

  article.save(function(err){
    if(!err){
      res.redirect('/');
    }
    else{
      res.redirect('/article/add');
    }
  });
};

exports.showEdit = function(req, res){
  Article.findById(req.params.id, function(err, data){
    res.render("article/edit_article", { 
      title: 'Edit article',
      page: 'page-edit-article',
      article: data 
    });
  });
};

exports.edit = function(req, res){
  Article.findById(req.params.id, function(err, data){
    a = req.body.article;
    data.enTitle = a.enTitle;
    data.cnTitle = a.cnTitle;
    data.url = a.url;
    data.abstract = a.abstract;
    data.completion = a.completion;
    data.paraList = a.paraList;

    data.save(function(err){
      if(!err){
        res.send(200, { result: 1 });
      }
      else{
        res.send(500, { result: 0 });
      }
    });
  });
};

exports.delete = function(req, res){
  Article.remove({ _id: req.params.id }, function(err){
    if(!err){
      res.redirect('/');
    }
    else{
      res.redirect('/article/' + req.params.id);
    }
  });
};
