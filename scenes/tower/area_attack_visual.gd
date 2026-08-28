class_name AreaAttackVisual
extends CPUParticles2D

@export var attack_area: AttackRange


func _ready() -> void:
	if attack_area.is_node_ready():
		_setup()
	else:
		attack_area.ready.connect(_setup)


func _setup() -> void:
	emission_sphere_radius = attack_area.size


func attack() -> void:
	emitting = true
