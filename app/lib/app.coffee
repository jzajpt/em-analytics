App.firstChartSeriesController = App.ChartSeriesController.create
  key: 'trials'

App.secondChartSeriesController = App.ChartSeriesController.create
  includeBlank: true

App.chartDataController = App.ChartDataController.create()

App.totalsController = App.TotalsController.create()

App.appController = Em.Object.create
  _data: null

  populate: (callback) ->
    $.get '/data.js', ((data) =>
      @_data =
        monthly: new App.DataSeries(data.monthly)
        daily: new App.DataSeries(data.daily)
      @daily()
      @_populateDidFinish()
    ), 'json'

  _populateDidFinish: ->
    App.chartDataController.setup()
    App.chartDataController.addSeriesController App.firstChartSeriesController
    App.chartDataController.addSeriesController App.secondChartSeriesController

  daily: ->
    App.chartDataController.set 'dateFormat', "%d. %m. %y"
    @_setData @_data.daily

  monthly: ->
    App.chartDataController.set 'dateFormat', "%y/%m"
    @_setData @_data.monthly

  _setData: (data) ->
    App.chartDataController.setData data
    App.totalsController.populate data

$ ->
  App.appController.populate()

