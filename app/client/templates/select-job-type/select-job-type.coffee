Template.SelectJobType.helpers
  jobs: ->
    if Template.instance()._jobFilter.get()  is ''
      Documents.find({})
    else
      Documents.find({name:Template.instance()._jobFilter.get()})

Template.SelectJobType.events
  'submit #search-form': (e,tmp) ->
    e.preventDefault()
    tmp._jobFilter.set tmp.$('input').val()

Template.SelectJobType.onCreated ()->
  @_jobFilter = new ReactiveVar('')