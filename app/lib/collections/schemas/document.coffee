schema = new SimpleSchema
  name:
    type: String
    label: 'Назва'
    min: 2
    max: 140
  fields:
    type: [schemas.DocumentField]
    label: 'Властивості'
    minCount: 1
    maxCount: 2**16


Namespace 'schemas', Document: schema