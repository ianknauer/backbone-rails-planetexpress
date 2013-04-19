@PlanetExpress.module "HeaderApp.List", (List, App, Backbone, Marionette, $, _) ->
	
	class List.Controller extends App.Controllers.Base
		
		initialize: ->
			listView = @getListView()
			
			@listenTo listView, "close", @close
			
			@show listView
		
		getListView: ->
			new List.Header