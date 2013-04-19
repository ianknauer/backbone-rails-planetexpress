@PlanetExpress.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->
	
	class Controllers.Base extends Marionette.Controller
		
		constructor: (options = {}) ->
			console.warn options
			@region = options.region or App.request "default:region"
			super options
			@_instance_id = _.uniqueId("controller")
			App.execute "register:instance", @, @_instance_id
		
		close: (args...) ->
			delete @region
			super args
			App.execute "unregister:instance", @, @_instance_id			
		
		show: (layout) ->
			@listenTo(layout, "close", @close)
			@region.show layout