do ($) ->
	$.fn.toggleWrapper = (obj = {}, init = true) ->
		_.defaults obj,
			className: ""
			backgroundColor: if @css("backgroundColor") isnt "transparent" then @css("backgroundColor") else "white"
				
		$offset = @offset()
		$width 	= @outerWidth(false)
		$height = @outerHeight(false)
		
		if init
			$("<div>")
				.appendTo("body")
					.addClass(obj.className)
						.attr("data-wrapper", true)
							.css
								width: $width
								height: $height 
								top: $offset.top
								left: $offset.left
								position: "absolute"
								zIndex: 1000
								backgroundColor: obj.backgroundColor
		else
			$("[data-wrapper]").remove()