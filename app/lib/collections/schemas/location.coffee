schema = new SimpleSchema
  name:
    type: String
    label: 'Назва'
    min: 2
    max: 140
  longitude:
    type: Number
    decimal: true
    label: 'Довгота'
    optional: true,
  latitude:
    type: Number
    decimal: true
    label: 'Широта'
    optional: true
  type:
    type: String
    label: 'Тип'
    optional: true
  description:
    type: String
    label: 'Опис'
    optional: true
  cropsHistory:
    type: [Object]
    label: 'Історія посівів'
    defaultValue: []
    maxCount: 2**16
  'cropsHistory.$.cropName':
    type: String
    label: 'Назва культури'
    min: 1
    max: 128
  'cropsHistory.$.startDate':
    type: Date
    label: 'Дата посіву'
    autoform:
      afFieldInput:
        type: 'bootstrap-datepicker'
  'cropsHistory.$.endDate':
    type: Date
    label: 'Дата збору'
    autoform:
      afFieldInput:
        type: 'bootstrap-datepicker'


Namespace 'schemas', Location: schema