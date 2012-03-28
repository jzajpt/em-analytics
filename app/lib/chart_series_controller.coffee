App.ChartSeriesController = Em.Object.extend
  # The output content for graph
  content: null

  # Current data label
  label: null

  # Current chart series key
  key: null

  # Input data object
  data: null

  # Include blank option in the labels property?
  includeBlank: false

  # Labels of possible series
  labels: ( ->
    data = @get 'data'
    if data
      labels = []
      data.each (key, label) ->
        labels.push key: key, label: label
      if @includeBlank
        labels.push(isSeparator: true)
        labels.push(key: '', label: "Cancel")
      labels
  ).property('data').cacheable()

  label: ( ->
    key = @get 'key'
    if key
      data = @get 'data'
      data.getLabel(key) if data
    else
      "..."
  ).property('data', 'key').cacheable()

  # Sets content when key or data property changes
  content: ( ->
    key = @get 'key'
    data = @get 'data'
    if key && data
      data.get(key)
    else
      []
  ).property('data', 'key').cacheable()


