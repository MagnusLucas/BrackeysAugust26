class_name WaveUI
extends PanelContainer

const WAVE_LENGTH_MULTIPLIER := 60
const WAVE_UI = preload("res://scenes/wave/wave_ui.tscn")

@export var wave: Wave : set = set_wave

@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var color_rect: ColorRect = $HBoxContainer/ColorRect
@onready var label: Label = $HBoxContainer/Label


static func new_from_wave(a_wave: Wave) -> WaveUI:
	var wave_ui: WaveUI = WAVE_UI.instantiate()
	wave_ui.set_wave(a_wave)
	return wave_ui


func set_wave(value) -> void:
	if wave:
		wave.enemy_spawned.disconnect(_update_label)
	wave = value
	if wave:
		wave.enemy_spawned.connect(_update_label)
	_update_visuals()


func _update_label() -> void:
	label.text = str(wave.number_of_enemies - wave.enemies_spawned)


func _update_visuals() -> void:
	if !wave:
		return
	if !is_node_ready():
		if ready.is_connected(_update_visuals):
			return
		ready.connect(_update_visuals, CONNECT_ONE_SHOT)
		return
	
	h_box_container.custom_minimum_size.x = WAVE_LENGTH_MULTIPLIER * wave.wave_length
	h_box_container.size.x = WAVE_LENGTH_MULTIPLIER * wave.wave_length
	color_rect.color = wave.enemy_colour
	color_rect.size_flags_stretch_ratio = wave.spawn_time
	label.text = str(wave.number_of_enemies)
	label.size_flags_stretch_ratio = wave.wave_length - wave.spawn_time
