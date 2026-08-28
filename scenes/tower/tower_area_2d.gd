class_name TowerArea2D
extends Area2D

signal picked_up
signal placed_down

enum State{
	ON_MAP,
	PICKED_UP
}

@export var tower: Tower

var current_state := State.ON_MAP


func _process(_delta: float) -> void:
	if current_state == State.PICKED_UP:
		tower.global_position = get_global_mouse_position()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if !event is InputEventMouseButton:
		return
	if !event.pressed:
		return
	if !event.button_index == MOUSE_BUTTON_LEFT:
		return
	
	match(current_state):
		State.ON_MAP:
			current_state = State.PICKED_UP
			picked_up.emit()
		State.PICKED_UP:
			current_state = State.ON_MAP
			placed_down.emit()


func _on_area_entered(bullet: Bullet) -> void:
	if bullet.source != self:
		tower.get_hit()
