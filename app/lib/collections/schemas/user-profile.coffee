schema = new SimpleSchema
  name:
    type: String
    label: "Ім'я"
    min: 2
    max: 140
  'location.latitude':
    type: Number
    decimal: true
    label: 'Latitude'
    defaultValue: 49.562035
  'location.longitude':
    type: Number
    decimal: true
    label: 'Latitude'
    defaultValue: 25.580463


Namespace 'schemas', UserProfile: schema