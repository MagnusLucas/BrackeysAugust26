extends Node

@onready var enemy_spawner: EnemySpawner = $EnemySpawner
@onready var wave_manager: WaveManager = $WaveManager
@onready var win_panel: PanelContainer = $WinPanel
@onready var base: Base = $Base
@onready var lose_panel: PanelContainer = $LosePanel

var last_wave_finished := false


func _ready() -> void:
	enemy_spawner.all_enemies_died.connect(_on_all_enemies_died)
	wave_manager.last_wave_finished_spawning.connect(
		func(): last_wave_finished = true
	)
	base.all_health_lost.connect(_on_base_died)


func _on_all_enemies_died() -> void:
	if last_wave_finished:
		win_panel.show()
		get_tree().paused = true


func _on_base_died() -> void:
	get_tree().paused = true
	lose_panel.show()
