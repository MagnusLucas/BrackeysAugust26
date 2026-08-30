extends VBoxContainer


# Called every frame. 'delta' is the elapsed time since the previous frame.
#handling button animation
func _process(_delta: float) -> void:
	#i am aware that this is not how one should use animation players, hoverer I am to pissed at how using atlas is a pain to stop commiting to this
	#this will cause no lagginess whatsoever :> i have faith
	if $Play.is_hovered():
		$Play/AnimationPlayer.play("play/play_focused")
	else:
		$Play/AnimationPlayer.play("play/play_idle")
	if $Settings.is_hovered():
		$Settings/AnimationPlayer.play("settings/settings_focused")
	else:
		$Settings/AnimationPlayer.play("settings/settings_idle")
	if $Credits.is_hovered():
		$Credits/AnimationPlayer.play("credits/credits_focused")
	else:
		$Credits/AnimationPlayer.play("credits/credits_idle")
	if $Quit.is_hovered():
		$Quit/AnimationPlayer.play("quit/quit_focused")
	else:
		$Quit/AnimationPlayer.play("quit/quit_idle")
	
	
	
