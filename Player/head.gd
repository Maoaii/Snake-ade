extends Area2D

signal consumed_point_powerup
signal speed_powerup
signal speed_powerdown
signal magnet_powerup
signal half_powerup

func _ready():
	# Set up head skin
	find_node("HeadSprite").texture = SkinSystem.current_head


func _on_head_area_entered(area):
	# Head collides with boundary wall or a tail => lose
	if area.name == "BoundaryWalls" or area.is_in_group("Player"):
		get_tree().change_scene("res://GameStates/LoseScreen/LoseScreen.tscn")
	# Head collides with a point powerup => add tail and + points
	if area.name == "PointPowerup":
		emit_signal("consumed_point_powerup")
	if area.name == "SpeedPowerup":
		emit_signal("speed_powerup")
		area.queue_free()
	if area.name == "SpeedPowerdown":
		emit_signal("speed_powerdown")
		area.queue_free()
	if area.name == "MagnetPowerup":
		emit_signal("magnet_powerup")
		area.queue_free()
	

