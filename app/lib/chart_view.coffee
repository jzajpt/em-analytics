#= require chart_tooltip

App.ChartView = Em.View.extend
  classNames: ['chart']

  # Options for flot
  plotOptions:
    colors: ["#08c", "#0c8"]
    lines:
      show: true
      fill: true
      fillColor: "rgba(0, 128, 200, 0.15)"
    points: { show: true }
    grid:
      color: "#aaa"
      borderWidth: 0
      hoverable: true
      clickable: true
    xaxis:
      mode: "time"

  # Format of date for time series
  dateFormat: "%y/%m"

  currentData: []

  # After element is inserted into the dom add observer for
  # content property and call the _draw method.
  didInsertElement: ->
    @addObserver 'content', @, '_contentDidChange'
    @_draw()

  # Handler method for when content property changes.
  _contentDidChange: ->
    @_draw()

  # Setup and draw the chart using Flot.
  _draw: ->
    content = @get 'content'
    if content
      layer = @$()
      @plotOptions.xaxis.timeformat = @get 'dateFormat'
      $.plot layer, content, @plotOptions
      @previousPoint = null
      layer.bind "plothover", @_plotHover

  # Handler method for when a plot is hovered with mouse.
  _plotHover: (event, pos, item) ->
    if item && @previousPoint != item.dataIndex
      @previousPoint = item.dataIndex
      value = item.datapoint[1].toFixed(0)
      x = item.pageX
      y = item.pageY - 10
      if @tooltip
        @tooltip.hide()
        delete @tooltip
      @tooltip = new App.ChartTooltip x, y, value
      @tooltip.show()
    else if !item
      @previousPoint = null
      if @tooltip
        @tooltip.hide()

