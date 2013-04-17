@PlanetExpress.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
	
	class Entities.Model extends Backbone.Model
		
		save: (data, options = {}) ->
			isNew = @isNew()

			_.defaults options,
				wait: true
				success: _.bind(@saveSuccess, @, isNew, options.collection)
				error: _.bind(@saveError, @)
			
			super data, options
				
		saveSuccess: (isNew, collection) =>
			console.info "success", @, isNew
			if isNew ## model is being created 
				collection.add @ if collection
				collection.trigger "model:created", @ if collection
				@trigger "created", @
			else ## model is just being updated
				@collection.trigger "model:updated", @ if @collection
				@trigger "updated", @

		saveError: =>
			console.warn "error"