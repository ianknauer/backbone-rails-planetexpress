@PlanetExpress.module "Components.Form", (Form, App, Backbone, Marionette, $, _) ->
	
	class Form.View extends App.Views.Layout
		template: "form/form"
		
		tagName: "form"
		attributes: ->
			"data-type": @getFormDataType()
			
		triggers:
			"submit" 														: "form:submit"
			"click [data-form-button='cancel']" : "form:cancel"
		
		modelEvents:
			"sync:start" 			: "syncStart"
			"sync:stop" 			: "syncStop"
			"change:_errors"	: "changeErrors"
			
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
		
		syncStart: (model) ->
			@addOpacityWrapper() if @config.syncing
		
		syncStop: (model) ->
			@addOpacityWrapper(false) if @config.syncing
		
		changeErrors: (model, errors, options) ->
			if @config.errors
				if _.isEmpty(errors) then @removeErrors() else @addErrors(errors)
		
		removeErrors: =>
			@$(".error").removeClass("error").find("small").remove()
		
		addErrors: (errors = {}) ->
			for name, array of errors
				@addError name, array[0]
		
		addError: (name, error) =>
			el = @$("[name='#{name}']")
			sm = $("<small>").text(error)
			el.after(sm).closest(".row").addClass("error")