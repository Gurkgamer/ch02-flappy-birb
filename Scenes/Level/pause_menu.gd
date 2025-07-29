extends CanvasLayer

var current_score: int = 0:
	set(value):
		current_score = value
		%CurrentScoreAPI.text = str(value)

var is_showing: bool = false
var gameover: bool = false

func _ready() -> void:
	current_score = 0
	var current_volume_db = AudioServer.get_bus_volume_db(0)
	var parsed_volume = db_to_linear(current_volume_db)
	%VolumeValueAPI.text = str(parsed_volume)
	%VolumeSliderAPI.value = parsed_volume

func _input(event: InputEvent) -> void:
	if gameover:
		return
		
	if event.is_action_pressed("menu"):
		if is_showing:
			hide()
			is_showing = false
		else:
			show()
			is_showing = true
		
		get_tree().paused = is_showing

func _on_reset_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func add_point() -> void:
	current_score += 1

func is_gameover() -> void:
	gameover = true

func _on_volume_slider_api_value_changed(value: float) -> void:
	var rounded_value = floor(value * 10) / 10
	print(rounded_value)
	%VolumeValueAPI.text = str(rounded_value)
	AudioServer.set_bus_volume_db(0, linear_to_db(rounded_value))
