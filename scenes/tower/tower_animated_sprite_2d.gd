class_name TowerAnimatedSprite2D
extends AnimatedSprite2D


func attack() -> void:
	play("attack")
	animation_finished.connect(
		func():
			play("idle"),
			CONNECT_ONE_SHOT
	)
