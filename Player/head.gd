extends Area2D

signal consumed_point_powerup
signal speed_powerup
signal speed_powerdown
signal magnet_powerup
signal half_powerup

onready var speedup_sound = $SpeedupSound
onready var speeddown_sound = $SpeeddownSound
onready var magnet_sound = $MagnetSound

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
		# Play powerup sound
		play_speedup_sound()
		emit_signal("speed_powerup")
		area.queue_free()
	if area.name == "SpeedPowerdown":
		# Play powerup sound
		play_speeddown_sound()
		emit_signal("speed_powerdown")
		area.queue_free()
	if area.name == "MagnetPowerup":
		# Play powerup sound
		play_magnet_sound()
		emit_signal("magnet_powerup")
		area.queue_free()


func play_speedup_sound():
	speedup_sound.stream = Global.SPEEDUP_SOUNDS[randi() % Global.SPEEDUP_SOUNDS.size()]
	speedup_sound.play()


func play_speeddown_sound():
	speeddown_sound.stream = Global.SPEEDDOWN_SOUNDS[randi() % Global.SPEEDDOWN_SOUNDS.size()]
	speeddown_sound.play()


func play_magnet_sound():
	magnet_sound.stream = Global.MAGNET_SOUNDS[randi() % Global.MAGNET_SOUNDS.size()]
	magnet_sound.play()
