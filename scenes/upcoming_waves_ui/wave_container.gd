class_name WaveContainer
extends HBoxContainer

@export var wave_array: Array[Wave] : set = set_wave_array


func set_wave_array(value) -> void:
	wave_array = value
	if wave_array:
		_update_waves()


func remove_all_children() -> void:
	for child in get_children():
		remove_child(child)
		child.queue_free() 


func _update_waves() -> void:
	if !is_node_ready():
		ready.connect(_update_waves, CONNECT_ONE_SHOT)
		return
	
	remove_all_children()
	for wave in wave_array:
		add_child(WaveUI.new_from_wave(wave))
	var spacer := Control.new()
	spacer.custom_minimum_size.x = 10000
	add_child(spacer)
