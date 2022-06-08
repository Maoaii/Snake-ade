extends Label


func _ready():
	if PointSystem.points > Highscore.highscore:
		Highscore.highscore = PointSystem.points

func _process(delta):
	if get_tree().get_current_scene().get_name() == "LoseScreen":
		self.text = "Points: " + str(PointSystem.points)
	else:
		self.text = "Points: " + str(PointSystem.points) + "\nModifier: " + str(PointSystem.point_modifier) + "x"
