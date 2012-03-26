# Class utilizing Bootstrap.tooltip function to show tooltip
# at given position (x and y) with given title.
class App.ChartTooltip
  constructor: (@x, @y, @title) ->

  # Show the tooltip. If tooltip is already present use this
  # method to update the position and title.
  show: ->
    unless @tooltip
      tooltip = $("<a href='#' rel='tooltip'></a>")
      @tooltip = tooltip.appendTo('body')
    @tooltip.css
      position: 'absolute'
      top: @y
      left: @x
    @tooltip.tooltip title: @title
    @tooltip.tooltip('show')

  # Hide the tooltip.
  hide: ->
    if @tooltip
      @tooltip.tooltip('hide')
      @tooltip.remove()
      @tooltip = null

