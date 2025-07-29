extends Node2D

@onready var wall_generator: Node2D = %WallGenerator
@onready var ui: CanvasLayer = %UI
@onready var game_over: CanvasLayer = %GameOver
@onready var pause_menu: CanvasLayer = %PauseMenu

func _ready() -> void:
	wall_generator.scored.connect(func() -> void:
		ui.add_point()
		pause_menu.add_point()
		%PointSFX.play())
	wall_generator.obstacle_touched.connect(_on_game_over)
	%BGM.play()

func _on_world_limits_limit_touched() -> void:
	_on_game_over()
	
func _on_game_over() -> void:
	%GameOverSFX.play()
	game_over.show_game_over(ui.current_points)
	pause_menu.is_gameover()
