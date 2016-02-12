_.mixin
  get: (obj, attrPath) ->
    attrVal = obj
    attrPath = attrPath.split '.'
    for attrName in attrPath
      attrVal = attrVal[attrName]
      if _.isUndefined(attrVal) or _.isNull(attrVal)
        break
    attrVal