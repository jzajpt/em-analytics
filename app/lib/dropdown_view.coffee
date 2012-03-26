App.DropdownView = Em.CollectionView.extend
  itemViewClass: SC.View.extend
    click: ->
      content = @get 'content'
      parentView = @get 'parentView'
      parentView.set 'selection', content.key

