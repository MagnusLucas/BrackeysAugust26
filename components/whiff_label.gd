class_name WhiffLabel
extends Label


func _init() -> void:
	text = "WHIFFF!"
	visible = false


func _ready() -> void:
	show_and_animate()


func show_and_animate() -> void:
	visible = true
	var tween := self.create_tween()
	tween.tween_property(self, "position:y", position.y - 100, 1)
	tween.set_parallel()
	tween.tween_property(self, "modulate:a", 0, 1)
