App.TotalsController = Em.Object.extend
  content: null

  populate: (data) ->
    totals = for key in data.keys()
      label = data.getLabel key
      sum = data.sum key
      label: label, sum: sum
    @set 'content', totals


