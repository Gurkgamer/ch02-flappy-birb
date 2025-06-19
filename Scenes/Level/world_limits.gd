extends Node2D

signal limit_touched()

@onready var top_area: Area2D = %TopArea
@onready var bottom_area: Area2D = %BottomArea

func _ready() -> void:
	# Place the world top and bottom limits
	top_area.global_position.y = 0
	bottom_area.global_position.y = Util.screen_size.y

func on_limit_touched(body: Node2D) -> void:
	limit_touched.emit()
