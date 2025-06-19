extends CanvasLayer

@onready var your_score_api: Label = %YourScoreApi

func _on_button_pressed() -> void:
	hide()
	get_tree().paused = false
	get_tree().reload_current_scene()

func show_game_over(score: int) -> void:
	your_score_api.text = str(score)
	get_tree().paused = true
	show()
