class_name UpcomingWavesUI
extends PanelContainer

@export var wave_manager: WaveManager
@onready var wave_container: WaveContainer = $WaveMover/WaveContainer


func _ready() -> void:
	_set_upcoming_waves(wave_manager.get_wave_array())


func _set_upcoming_waves(wave_array: Array[Wave]) -> void:
	wave_container.set_wave_array(wave_array)
