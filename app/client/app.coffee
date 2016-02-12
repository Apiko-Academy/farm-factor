Template.registerHelper 'collections', () ->
  collectionsList = Mongo.Collection.getAll()
  collections = {}
  _.each collectionsList, (item) ->
    collections[item.name] = item.instance
  collections