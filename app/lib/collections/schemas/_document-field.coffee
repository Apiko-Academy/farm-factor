documentDefinitionField =
  label:
    type: String
    label: 'Мітка'
    min: 2
    max: 140
  unit:
    type: String
    label: 'Одиниці вимірювання'
    optional: true
    min: 1
    max: 64
  type:
    type: String
    label: 'Тип даних'
    min: 1
    max: 64
    autoform:
      options: [
        value: 'String'
        label: 'Стрічка'
      ,
        value: 'Number'
        label: 'Число'
      ,
        value: 'Date'
        label: 'Дата'
      ,
        value: 'Location'
        label: 'Локація'
      ,
        value: 'User'
        label: 'Працівник'
      ]
  defaultValue:
    type: String
    optional: true
    label: 'Значення по замовчуванню'
    autoValue: () ->
      if _.isString @value
        @value
      else
        EJSON.stringify @value


documentField = _.extend {}, documentDefinitionField,
  value:
    type: String
    label: 'Значення'
    optional: true
    autoValue: () ->
      if _.isString @value
        @value
      else
        EJSON.stringify @value
  date:
    type: Date
    label: 'Дата'
    autoform:
      type: 'hidden'
    autoValue: ->
      new Date()


Namespace 'schemas', rawDocumentDefinitionField:
  documentDefinitionField
Namespace 'schemas', DocumentDefinitionField:
  new SimpleSchema documentDefinitionField

Namespace 'schemas', rawDocumentField:
  documentField
Namespace 'schemas', DocumentField:
  new SimpleSchema documentField
