extends Label


func _process(delta):
	self.text = "Speed: " + str(PointSystem.movement_speed)
