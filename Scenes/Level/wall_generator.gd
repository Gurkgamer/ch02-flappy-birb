extends Node2D

signal scored()
signal obstacle_touched()

@export var wall_obstacle: PackedScene
var wall_gap_size: float = 150.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _spawn_wall() -> void:
	var new_obstacle = wall_obstacle.instantiate()
	new_obstacle.wall_gap_size = wall_gap_size
	add_child(new_obstacle)
	new_obstacle.touched.connect(func() -> void: obstacle_touched.emit())
	new_obstacle.point.connect(func () -> void: scored.emit())
	
func _on_new_obstacle_timer_timeout() -> void:
	_spawn_wall()
