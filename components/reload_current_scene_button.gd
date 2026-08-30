class_name ReloadCurrentSceneButton
extends Button


func _ready() -> void:
	pressed.connect(_reload)
	text = "RESTART"


func _reload() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
