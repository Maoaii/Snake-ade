extends Button


func _on_CharacterPickButton_pressed():
	SkinSystem.change_skin(self.text)
	get_tree().change_scene("res://GameStates/Levels/TestLevel.tscn")


