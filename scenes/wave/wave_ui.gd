@tool
class_name WaveUI
extends PanelContainer

const WAVE_LENGTH_MULTIPLIER := 30

@export var wave: Wave : set = set_wave

@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var color_rect: ColorRect = $HBoxContainer/ColorRect
@onready var label: Label = $HBoxContainer/Label


func set_wave(value) -> void:
	wave = value
	_update_visuals()


func _update_visuals() -> void:
	if !wave:
		return
	if !is_node_ready():
		ready.connect(_update_visuals, CONNECT_ONE_SHOT)
		return
	
	h_box_container.custom_minimum_size.x = WAVE_LENGTH_MULTIPLIER * wave.wave_length
	h_box_container.size.x = WAVE_LENGTH_MULTIPLIER * wave.wave_length
	color_rect.color = wave.enemy_colour
	color_rect.size_flags_stretch_ratio = wave.spawn_time
	label.text = str(wave.number_of_enemies)
	label.size_flags_stretch_ratio = wave.wave_length - wave.spawn_time
