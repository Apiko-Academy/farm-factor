Template.Dashboard.helpers
  date: ->
    moment.locale('uk')
    moment().format("dddd, DD.MM.YYYY")
  tempTableData: ->
    _.map [0..7], ->
      date1: chance.date({string: true, american: false, year: 2015})
      name1: chance.name()
      name2: chance.domain()
      number1: chance.natural()
      number2: chance.floating({min: 10, max: 100})
      number3: chance.natural({min: 100, max: 10000})
      number4: chance.floating()