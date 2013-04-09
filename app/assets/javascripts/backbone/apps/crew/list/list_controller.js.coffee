@PlanetExpress.module "CrewApp.List", (List, App, Backbone, Marionette, $, _) ->
	
	List.Controller =
		
		list: ->
			@layout = @getLayoutView()
			
			@layout.on "show", =>
				@titleRegion()
				@panelRegion()
				@newRegion()
				@crewRegion()
			
			App.mainRegion.show @layout
		
		titleRegion: ->
			titleView = @getTitleView()
			@layout.titleRegion.show titleView
		
		panelRegion: ->
			panelView = @getPanelView()
			@layout.panelRegion.show panelView
		
		newRegion: ->
			newView = @getNewView()
			@layout.newRegion.show newView
		
		crewRegion: ->
			crewView = @getCrewView()
			@layout.crewRegion.show crewView
		
		getCrewView: ->
			new List.Crew
		
		getNewView: ->
			new List.New
		
		getPanelView: ->
			new List.Panel
		
		getTitleView: ->
			new List.Title
		
		getLayoutView: ->
			new List.Layout