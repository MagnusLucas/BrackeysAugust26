class_name Base
extends Area2D

@export var base_stats: BaseStats

@onready var health_container: HBoxContainer = %HealthContainer


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	_update_visuals()
	base_stats.lost_all_health.connect(_on_lost_all_health)


func _update_visuals() -> void:
	for child_idx in health_container.get_child_count():
		var child: TextureRect = health_container.get_child(child_idx)
		child.visible = base_stats.hp > child_idx


func _on_area_entered(area: Area2D) -> void:
	area.queue_free()
	base_stats.set_health(base_stats.hp - 1)
	_update_visuals()


func _on_lost_all_health() -> void:
	get_tree().change_scene_to_file.call_deferred("res://scenes/main_menu.tscn")
