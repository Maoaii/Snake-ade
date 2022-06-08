extends Label


func _process(delta):
	self.text = "Points: " + str(PointSystem.points) + "\nModifier: " + str(PointSystem.point_modifier) + "x"

