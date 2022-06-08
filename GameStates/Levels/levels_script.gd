extends Control

func _process(delta):
	# Quit game input
	quit_game_input()


# Quit the game
func quit_game_input():
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
