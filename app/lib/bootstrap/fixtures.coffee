# Return all the assets by given path
getAssets = (assetsDir) ->
  assetsPath = path.join Meteor.rootPath, 'assets', 'app'
  fullPath = path.join assetsPath, assetsDir
  try
    files = fs.readdirSync fullPath
  catch
    console.log "Can't load fixtures from directory '#{assetsDir}'!"
    return assets
  _.map files, (fileName) ->
    filePath = path.join assetsDir, fileName
    EJSON.parse Assets.getText(filePath)


# Insert given asserts to collection
fillCollection = (collection, assets) ->
  unless collection.find().count()
    _.each assets, (doc) ->
      collection.insert doc
      if collection is Meteor.users and doc.roles
        Roles.addUsersToRoles doc._id, doc.roles


# Write logs
logAction = (assetsNumber, collectionName) ->
  if _.every arguments, _.identity
    msg = [
      "Created #{assetsNumber} new fixtures",
      "for the #{collectionName} collection."
    ]
    msg = msg.join ' '
    console.log msg


# On application start
Meteor.startup () ->
  if not Meteor.isServer
    return
  # Path to fixtures
  fixturesPath = 'fixtures'
  # Read configs
  fixturesConfigs = path.join fixturesPath, 'configs.json'
  fixturesConfigs = EJSON.parse Assets.getText(fixturesConfigs)
  # Fill the collections with a fixtures
  _.each fixturesConfigs, (assetsDir, collectionName) ->
    # Get link to collection
    collection = _.get @, collectionName
    # Do nothing if collection is not empty
    if collection.find().count()
      return
    # Read fixtures
    assetsDir = path.join fixturesPath, assetsDir
    assets = getAssets assetsDir
    if assets.length
      # Fill collection with fixtures
      fillCollection collection, assets
      # Write logs
      logAction assets.length, collectionName