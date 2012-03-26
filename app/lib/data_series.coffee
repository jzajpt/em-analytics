class App.DataSeries
  constructor: (@data) ->

  # Get the sum for given key.
  sum: (key) ->
    sum = 0
    data = @data[key].data
    for item in data
      sum += item[1]
    sum

  get: (key) ->
    @data[key]

  getLabel: (key) ->
    @data[key].label

  getData: (key) ->
    @data[key].data

  # Returns all present keys
  keys: ->
    key for key, value of @data

  each: (callback) ->
    for key, value of @data
      callback(key, value.label, value.data)

