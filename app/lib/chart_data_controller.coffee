# Controller that acts as facade for series controllers.
App.ChartDataController = Em.Object.extend
  series: []

  # Setup the controller - this method needs to be called before
  # registering any series controllers via addSeriesController.
  setup: -> @set 'series', []

  # Registers new series controller that hold the data for one
  # particular series: sets the data property and adds observer
  # for content property.
  addSeriesController: (controller) ->
    series = @get 'series'
    controller.set 'data', @get('data')
    controller.addObserver 'content', @, 'updateContent'
    @series.pushObject controller

  # Content property for the chart view. Returns data from
  # each series controller.
  content: ( ->
    series = @get 'series'
    if series
      series.getEach('content')
    else
      []
  ).property('series').cacheable()

  # Handler function for when data property changes.
  setData: (data) ->
    @set 'data', data
    series = @get 'series'
    series.setEach 'data', data

  # Invalidates content property.
  updateContent: ->
    @notifyPropertyChange 'content'

  # Returns string period that is represented by data property.
  period: ( ->
    data = @get 'data'
    if data
      seriesData = data.get('trials').data
      first = seriesData[0][0]
      last = seriesData[seriesData.length - 1][0]
      firstDate = new Date(first)
      lastDate = new Date(last)
      "#{_formatDate firstDate} - #{_formatDate lastDate}"
  ).property('data').cacheable()

  # Formats given date to Czech date format
  _formatDate = (date) ->
    year = date.getFullYear()
    month = date.getMonth() + 1
    day = date.getDate()
    "#{day}. #{month}. #{year}"

