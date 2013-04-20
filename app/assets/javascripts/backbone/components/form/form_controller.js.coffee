@PlanetExpress.module "Components.Form", (Form, App, Backbone, Marionette, $, _) ->
	
	class Form.Controller extends Marionette.Controller
		
		initialize: (view, options = {}) ->
			@contentView = view
			
			@formLayout = @getFormLayout options
						
			@listenTo @formLayout, "show", @formContentRegion			
			@listenTo @formLayout, "close", @close
			@listenTo @formLayout, "form:submit", @formSubmit
		
		formSubmit: ->
			data = Backbone.Syphon.serialize(@formLayout)
			
			# console.info @contentView.triggerMethod "form:submit"
			
			# console.log data

			if @contentView.triggerMethod("form:submit", data) isnt false
				entities = _.pick @contentView, "model", "collection"

				@processFormSubmit data, entities
		
		processFormSubmit: (data, entities) ->
			model = entities.model
			collection = entities.collection
			throw new Error "no model found inside of entities" unless model
			model.save(data, collection: collection) if model
		
		onClose: ->
			delete @formLayout
			delete @contentView
			delete @options			
			console.log "onClose", @
		
		formContentRegion: ->
			@formLayout.formContentRegion.show @contentView
		
		getFormLayout: (options) ->
			config = @getDefaultOptions _.result(@contentView, "form") 
			
			buttons = @getButtons config.buttons
			
			new Form.View
				config: config
				buttons: buttons
		
		getDefaultOptions: (config = {}) ->
			_.defaults config,
				focusFirstInput: true
				footer: true
		
		getButtons: (buttons = {}) ->
			App.request("form:button:entities", buttons, @contentView.model) unless buttons is false	
	
	App.reqres.setHandler "form:wrapper", (view, options = {}) ->
		formController = new Form.Controller(view, options)
		formController.formLayout
