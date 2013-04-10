@PlanetExpress.module "CrewApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->
	
	class Edit.Layout extends App.Views.Layout
		template: "crew/edit/edit_layout"
		
		regions:
			formRegion: "#form-region"
	
	class Edit.Crew extends App.Views.ItemView
		template: "crew/edit/_edit_crew"
		
		# form:
		# 	buttons:
		# 		primary: "foo"
		# 		cancel: false
		# 		placement: "left"