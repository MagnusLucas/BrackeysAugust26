class_name BackToMainMenuButton
extends Button


func _ready() -> void:
	pressed.connect(_back_to_main_menu)


func _back_to_main_menu() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
