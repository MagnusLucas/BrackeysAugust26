class_name TowerStats
extends Resource

enum AttackShape{
	BULLET,
	AREA,
}

enum AttackTarget{
	ENEMY,
	TOWER,
	BASE,
}

enum AttackEffect{
	DAMAGE,
	BUFF,
}

@export var see_range: float
@export var attack_interval: float

@export var attack_shape: AttackShape

@export var damage_per_bullet := 10.0
@export var buff_percent := 100.0
@export var buff_duration := 1.0

@export var attack_target: AttackTarget
