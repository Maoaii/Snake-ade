extends Button


# Change to first level after clicking button
func _on_StartButton_pressed():
	get_tree().change_scene("res://GameStates/CharacterPickScreen/CharacterPickScreen.tscn")
