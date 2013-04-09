@PlanetExpress.module "CrewApp.List", (List, App, Backbone, Marionette, $, _) ->
	
	List.Controller =
		
		list: ->
			listView = @getListView()
			
			App.mainRegion.show listView
		
		getListView: ->
			new List.Crew