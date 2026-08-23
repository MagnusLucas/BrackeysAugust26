@tool
class_name AttackRange
extends Area2D

@export var size := 100.0 : set = _set_size
var collision_shape: CollisionShape2D


func _ready() -> void:
	collision_shape = CircleCollisionShape.new()
	add_child(collision_shape)
	collision_shape.size = size


func _set_size(value) -> void:
	size = value
	collision_shape.size = size
