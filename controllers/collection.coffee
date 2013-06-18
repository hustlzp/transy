###
Collection Controller
###

url = require('url')
Collection = require('../models/collection')
Article = require('../models/article')
mongoose = require('mongoose')
ObjectId = mongoose.Types.ObjectId

# collections
exports.collections = (req, res)->
  Collection
  .find()
  .exec (err, cols)->
    res.render('collection/collections', { cols: cols })

# single collection
exports.collection = (req, res)->
  Collection
  .findById(req.params.id)
  .exec (err, c)->
    Article
    .find({ col: c.id })
    .populate('creator')
    .populate('col')
    .exec (err, articles)->
      res.render('collection/collection', { c: c, articles: articles })

# add collection page
exports.showAdd = (req, res)->
  res.render('collection/add_collection')

# add collection
exports.add = (req, res)->
  if req.form.isValid
    c = new Collection
      _id: new ObjectId()
      creator: req.cookies.user.id
      type: req.form.type
      title: req.form.title
      intro: req.form.intro
      image: req.form.image
    c.save (err)->
      if not err
        res.redirect("/collection/#{c._id}")
      else
        next(err)
  else
    res.render('collection/add_collection', { form: req.form })

# # edit collection page
# exports.showEdit = (req, res)->
#   Collection
#   .findById(req.params.id)
#   .exec (err, data)->
#     if not err
#       res.render('collection/edit_collection', { cid: data.id, form: data })
#     else
#       next(err)

# # edit collection
# exports.edit = (req, res)->
#   if req.form.isValid
#     Collection
#     .findById(req.params.id)
#     .exec (err, data)->
#       data.type = req.form.type
#       data.title = req.form.title
#       data.intro = req.form.intro
#       data.image = req.form.intro
#       data.save (err)->
#         res.redirect("/collection/#{data.id}")
#   else
#     res.render('collection/edit_collection',
#       cid: req.params.id
#       form: req.form
#     )

# edit collection
exports.edit = (req, res)->
  Collection
  .findById(req.params.id)
  .exec (err, data)->
    switch req.method
      when 'GET'
        res.render('collection/edit_collection', { cid: data.id, form: data })
      when 'POST'
        if req.form.isValid
          data.type = req.form.type
          data.title = req.form.title
          data.intro = req.form.intro
          data.image = req.form.image
          data.save (err)->
            res.redirect("/collection/#{data.id}")
        else
          res.render('collection/edit_collection', { cid: data.id, form: req.form })

# delete collection
exports.delete = (req, res)->
  Collection
  .remove(_id: req.params.id)
  .exec (err, data)->
    res.redirect('/collections')