schema = new SimpleSchema
  services:
    type: Object
    optional: true
    blackbox: true
  username:
    label: 'Логін'
    type: String
    min: 2
    max: 140
  profile:
    type: schemas.UserProfile
    label: 'Профіль'
  createdAt:
    type: Date
    label: 'Створений'
    denyUpdate: true
    autoform:
      type: 'hidden'
    autoValue: () ->
      new Date() if @isInsert
  roles:
    type: [String]
    label: 'Ролі'
    optional: true
    blackbox: true


Namespace 'schemas', User: schema
