@PlanetExpress.module "CrewApp.List", (List, App, Backbone, Marionette, $, _) ->
	
	class List.Crew extends App.Views.ItemView
		template: "crew/list/crew"