extends CanvasLayer

var current_points: int = 0

func add_point() -> void:
	current_points +=1
	%PointApi.text = str(current_points)
