Template.ChartDisplay.onCreated ->
  @randomChartType = ['area', 'spline'][_.random(0, 1)]
  @series = [{name: '', data: []}]
  @series = []
  @categories = []
  Documents.find().forEach (doc) =>
    for field in doc.fields
      if field.type is 'Number'
        wasUpdated = false
        for aSerie, index in @series
          if aSerie.name is field.label
            @categories.push window.performance.now() * 100
            aSerie.data.push field.value
            wasUpdated = true
        if not wasUpdated
          @categories.push window.performance.now() * 100
          @series.push {name: field.label, data: [field.value]}


  @categories = _.sample @categories, @series[0].data.length
  @categories = @categories.sort()
  if _.sample([true, false], 1)
    @categories = @categories.reverse()
  console.log @categories, @series

Template.ChartDisplay.onRendered ->
  @$('.chart').last().highcharts {
    chart:
      type: @data.type
    credits:
      enabled: false
    title:
      text: chance.first()
    series: @series
  }
