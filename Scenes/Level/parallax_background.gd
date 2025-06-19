extends Node

@onready var _1: Sprite2D = %"1"
@onready var _2: Sprite2D = %"2"
@onready var _4: Sprite2D = %"4"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	_1.global_position = Util.screen_size / 2
	_2.global_position = Util.screen_size / 2
	_4.global_position = Util.screen_size / 2
	_1.scale = Util.screen_size / _1.texture.get_size()
	_2.scale = Util.screen_size / _2.texture.get_size()
	_4.scale = Util.screen_size / _4.texture.get_size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
