extends Node2D

signal touched()
signal point()

@onready var gap_collision_shape: CollisionShape2D = %GapCollisionShape
@onready var point_gap: Area2D = %PointGap

var wall_package: PackedScene = load("res://Scenes/Actors/Wall/wall.tscn")
var wall_gap_size: float = 200.0 # Se pone al instanciar
var obstacle_speed: float = 400.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_create_wall_obstacle()
	
	$VisibleOnScreenNotifier2D.global_position.y = Util.screen_size.y / 2
	
func _process(delta: float) -> void:
	global_position.x -= obstacle_speed * delta

func _create_wall_obstacle() -> void:
	#Primero elegir punto donde aparecerá el gap
	#Separar la pantalla en tres partes. La del medio será la zona donde puede aparecer el gap
	var vertical_screen_chunk_size: float = Util.screen_size.y / 3
	var top_max_height: float = vertical_screen_chunk_size
	var bottom_max_height: float = vertical_screen_chunk_size * 2
	
	var gap_center_spawn_point: float = randf_range(top_max_height, bottom_max_height)
	gap_collision_shape.global_position.y = gap_center_spawn_point
	
	gap_collision_shape.shape.size.y = wall_gap_size
	gap_collision_shape.shape.size.x = 50
	
	# Ahora con el centro elegido, se coge la altura para saber donde empezará cada parez
	var top_wall_spawn_point: float = gap_center_spawn_point - (wall_gap_size / 2)
	var bottom_wall_spawn_point: float = gap_center_spawn_point + (wall_gap_size / 2)
	
	# Cambiar esto para que empiece fuera de la pantalla
	# TODO
	global_position.x = Util.screen_size.x
	
	var top_wall_instance: Area2D = wall_package.instantiate()
	top_wall_instance.global_position.y = top_wall_spawn_point
	
	var bottom_wall_instance: Area2D = wall_package.instantiate()
	bottom_wall_instance.rotate(PI)
	bottom_wall_instance.global_position.y = bottom_wall_spawn_point
	
	add_child(top_wall_instance)
	add_child(bottom_wall_instance)
	
	top_wall_instance.body_entered.connect(func(body: Node2D) -> void:
		touched.emit())
	bottom_wall_instance.body_entered.connect(func(body: Node2D) -> void:
		touched.emit())
	point_gap.body_entered.connect(func(body: Node2D) -> void:
		point.emit())
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
