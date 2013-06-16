###
Collection Controller
###

url = require('url')
Collection = require('../models/collection')
mongoose = require('mongoose')
ObjectId = mongoose.Types.ObjectId

# collections
exports.collections = (req, res)->
  res.render('collection/collections')

# single collection
exports.collections = (req, res)->
  res.render('collection/collection')

# add collection
exports.add = (req, res)->
  res.render('collection/add')