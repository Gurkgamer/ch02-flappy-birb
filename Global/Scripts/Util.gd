extends Node

var screen_size: Vector2: # Facilita coger el tamaño de la ventana sin tener que escribir todo
	set(value):
		pass
	get:
		return get_viewport().get_visible_rect().size

var game_screen_resolution: Vector2:
	set(value):
		pass
	get:
		var height = ProjectSettings.get_setting("display/window/size/viewport_height")
		var width = ProjectSettings.get_setting("display/window/size/viewport_width")
		return Vector2(width, height)
