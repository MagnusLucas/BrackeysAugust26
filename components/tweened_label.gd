class_name TweenedLabel
extends Label

var end_offset := 100
var animation_time := 1.0


func _init(label_text := "TWEEN!", post_tween_offset := 100, tween_time := 1.0) -> void:
	text = label_text
	end_offset = post_tween_offset
	animation_time = tween_time
	visible = false


func _ready() -> void:
	show_and_animate()


func show_and_animate() -> void:
	visible = true
	var tween := self.create_tween()
	tween.tween_property(self, "position:y", position.y - end_offset, animation_time)
	tween.set_parallel()
	tween.tween_property(self, "modulate:a", 0, animation_time)
