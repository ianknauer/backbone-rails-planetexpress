@PlanetExpress.module "Components.Form", (Form, App, Backbone, Marionette, $, _) ->
	
	class Form.Controller extends App.Controllers.Base
		
		initialize: (options = {}) ->
			@contentView = options.view
			
			@formLayout = @getFormLayout options.config
			
			@listenTo @formLayout, "show", @formContentRegion
			@listenTo @formLayout, "form:submit", @formSubmit
			@listenTo @formLayout, "form:cancel", @formCancel
		
		formSubmit: ->
			data = Backbone.Syphon.serialize(@formLayout)
			
			# console.info @contentView.triggerMethod "form:submit"
			
			# console.log data

			if @contentView.triggerMethod("form:submit", data) isnt false
				entities = _.pick @contentView, "model", "collection"

				@processFormSubmit data, entities
		
		formCancel: ->
			# console.log "formCancel"
			@contentView.triggerMethod("form:cancel")			
		
		processFormSubmit: (data, entities) ->
			model = entities.model
			collection = entities.collection
			model.save data, 
				collection: collection
		
		onClose: ->
			delete @formLayout
			delete @contentView
			delete @options			
			console.log "onClose", @
		
		formContentRegion: ->
			@region = @formLayout.formContentRegion
			@show @contentView
		
		getFormLayout: (options) ->
			config = @getDefaultOptions _.result(@contentView, "form") 
			
			buttons = @getButtons config.buttons
			
			new Form.FormWrapper
				config: config
				buttons: buttons
				model: @contentView.model
		
		getDefaultOptions: (config = {}) ->
			_.defaults config,
				focusFirstInput: true
				footer: true
				syncing: true
				errors: true
		
		getButtons: (buttons = {}) ->
			App.request("form:button:entities", buttons, @contentView.model) unless buttons is false	
	
	App.reqres.setHandler "form:wrapper", (contentView, options = {}) ->
		throw new Error "no model found inside of form's contentView", contentView unless contentView.model
		formController = new Form.Controller
			view: contentView
			config: options
		formController.formLayout
