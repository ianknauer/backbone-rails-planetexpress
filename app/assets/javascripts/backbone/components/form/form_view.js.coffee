@PlanetExpress.module "Components.Form", (Form, App, Backbone, Marionette, $, _) ->
	
	class Form.View extends App.Views.Layout
		template: "form/form"
		
		tagName: "form"
		attributes: ->
			"data-type": @getFormDataType()
			
		triggers:
			"submit" 														: "form:submit"
			"click [data-form-button='cancel']" : "form:cancel"
			
		regions:
			formContentRegion: "#form-content-region"
		
		ui:
			buttonContainer: "ul.inline-list"
		
		initialize: ->
			@setInstancePropertiesFor "config", "buttons"
		
		getFormDataType: ->
			if @model?.isNew() then "new" else "edit"
		
		serializeData: ->
			footer: @config.footer
			buttons: @buttons?.toJSON() ? false
		
		onShow: ->
			_.defer =>
				@focusFirstInput() if @config.focusFirstInput
				@buttonPlacement() if @buttons
		
		focusFirstInput: ->
			@$(":input:visible:enabled:first").focus()
		
		buttonPlacement: ->
			@ui.buttonContainer.addClass @buttons.placement