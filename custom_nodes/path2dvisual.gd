@tool
class_name Path2DVisual
extends Line2D

@export var colour: Color
@export_tool_button("Generate path visual") var callable := _on_generate_path_visual_pressed


func _on_generate_path_visual_pressed() -> void:
	if not get_parent() is Path2D:
		printerr("Parent is not Path2D")
		return
	points = []
	var new_points: Array[Vector2] = []
	var path2d: Path2D = get_parent()
	for point_id in path2d.curve.point_count:
		new_points.append(path2d.curve.get_point_position(point_id))
	points = new_points
	default_color = colour
