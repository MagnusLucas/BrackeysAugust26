class_name WaveMover
extends ScrollContainer


var float_scroll_value := 0.0


func _process(delta: float) -> void:
	float_scroll_value += delta * WaveUI.WAVE_LENGTH_MULTIPLIER
	scroll_horizontal = int(float_scroll_value)
