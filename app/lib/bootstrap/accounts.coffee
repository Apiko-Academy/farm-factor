AccountsTemplates.configure
  enablePasswordChange: false

AccountsTemplates.removeField 'email'
AccountsTemplates.removeField 'password'

AccountsTemplates.addField
  _id: 'username'
  type: 'text'
  displayName: 'Логін'
  placeholder: 'Логін'
  required: true
  minLength: 2
  maxLength: 140
  #re: /^[\w\s]{2,140}$/
  errStr: 'Дозволені тільки букви і цифри'
  func:(value)->
    self = this
    if Meteor.isClient
      Meteor.call 'userExists', value, (err, userExists) ->
        if !userExists
          self.setSuccess()
        else
          self.setError userExists
          self.setValidating false
        return
    if Meteor.isServer
      Meteor.call 'userExists', value


AccountsTemplates.addField
  _id: 'name'
  type: 'text'
  displayName: 'Повне ім\'я'
  placeholder: 'Повне ім\'я'
  required: true
  minLength: 2
  maxLength: 140
  re: /^[\w\s]{2,140}$/
  errStr: 'Дозволені тільки букви і цифри'

AccountsTemplates.addField
  _id: 'password'
  type: 'password'
  displayName: 'Пароль'
  placeholder: 'Парль'
  required: true
  minLength: 6

T9n.setLanguage 'uk'