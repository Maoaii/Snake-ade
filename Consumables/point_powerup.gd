extends Area2D

onready var consumed_sound = $ConsumedSound


func _ready():
	# Set up point consumable skin
	find_node("PointPowerupSprite").texture = SkinSystem.current_point_consumable
	
	# Set random position
	position = get_random_pos()

# Gets a random position in the board
func get_random_pos():
	return Vector2(((randi() % Global.BOARD_WIDTH) * Global.CELL_SIZE) + Global.OFFSET,
				  ((randi() % Global.BOARD_HEIGHT) * Global.CELL_SIZE) + Global.OFFSET)


func _on_PointPowerup_area_entered(area):
	play_consumed_sound()
	# If it was the player
	if area.is_in_group("Player"):
		# Shift place
		while area.position == position:
			position = get_random_pos()
	if area.name == "Magnet":
		position = get_random_pos()


func play_consumed_sound():
	consumed_sound.stream = Global.POINTPOWERUP_SOUNDS[randi() % Global.POINTPOWERUP_SOUNDS.size()]
	consumed_sound.play()
