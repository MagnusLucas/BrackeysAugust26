class_name SceneSpawner
extends Button

@export var parent: Node
@export var scene_to_spawn: PackedScene


func _ready() -> void:
	pressed.connect(_spawn_scene)


func _spawn_scene() -> void:
	var spawn_position := get_global_mouse_position()
	var scene := scene_to_spawn.instantiate()
	parent.add_child(scene)
	scene.global_position = spawn_position
