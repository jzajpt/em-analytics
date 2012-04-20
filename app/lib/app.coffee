App.firstChartSeriesController = App.ChartSeriesController.create
  key: 'trials'

App.secondChartSeriesController = App.ChartSeriesController.create
  includeBlank: true

App.chartDataController = App.ChartDataController.create()

App.totalsController = App.TotalsController.create()

App.appController = Em.Object.create
  _data: null

  periodOptions: [
    { title: "Daily", value: "daily" }
    { title: "Monthly", value: "monthly" }
  ]

  formats:
    daily: "%d. %m. %y"
    monthly: "%y/%m"

  populate: (callback) ->
    $.get '/data.js', ((data) =>
      @_data =
        monthly: new App.DataSeries(data.monthly)
        daily: new App.DataSeries(data.daily)
      @_populateDidFinish()
      @set 'period', 'daily'
    ), 'json'

  _populateDidFinish: ->
    App.chartDataController.setup()
    App.chartDataController.addSeriesController App.firstChartSeriesController
    App.chartDataController.addSeriesController App.secondChartSeriesController

  _setData: (data) ->
    App.chartDataController.setData data
    App.totalsController.populate data

  _periodDidChange: ( ->
    period = @get 'period'
    @_setData @_data[period]
    App.chartDataController.set 'dateFormat', @formats[period]
  ).observes('period')

$ ->
  App.appController.populate()

