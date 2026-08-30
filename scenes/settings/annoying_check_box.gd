class_name AnnoyingCheckBox
extends CheckBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	toggled.connect(_on_toggled)


func _on_toggled(_toggled_on : bool) -> void:
	button_pressed = false
	var tl := TweenedLabel.new("Your system doesn't support this. Have you tried using Linux?")
	tl.set_anchors_and_offsets_preset(Control.PRESET_CENTER_TOP)
	tl.add_theme_color_override("font_color", Color(0.647, 0.188, 0.188, 1.0))
	add_child(tl)
