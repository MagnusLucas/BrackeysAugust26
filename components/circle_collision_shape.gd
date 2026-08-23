@tool
class_name CircleCollisionShape
extends CollisionShape2D

@export var size := 10.0 : set = _set_size


func _ready() -> void:
	shape = CircleShape2D.new()
	shape.radius = size


func _set_size(value) -> void:
	size = value
	shape.radius = size
