@PlanetExpress.module "Components.Form", (Form, App, Backbone, Marionette, $, _) ->
	
	class Form.View extends App.Views.Layout
		template: "form/form"
		
		tagName: "form"
		attributes:
			"data-type": "edit"
			
		regions:
			formContentRegion: "#form-content-region"
		
		initialize: ->
			@config = @options.config
			console.warn "config", @config
		
		serializeData: ->
			footer: @options.config.footer
			buttons: @getButtons(@options.config.buttons)
			buttonPlacement: @options.config.buttons.placement
		
		onShow: ->
			_.defer =>
				@focusFirstInput() if @config.focusFirstInput
		
		focusFirstInput: ->
			@$(":input:visible:enabled:first").focus()
		
		getButtons: (buttons) ->
			return false unless buttons
			array = [
				{ type: "cancel", 	className: "button small secondary radius", text: buttons.cancel }
				{ type: "primary", 	className: "button small radius", 					text: buttons.primary }
			]
			array.reverse() if buttons.placement is "left"
			array