class_name MainMenu
extends PanelContainer


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/test_scene.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings/settings.tscn")
