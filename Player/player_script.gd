extends Node2D

# Dictionary of player parts
const PLAYER_PARTS = {
	"head": 0,
	"body": 1,
}

# Movement Timer
onready var movement_timer = $MovementTimer
onready var speedup_timer = $SpeedupTimer
onready var speed_down_timer = $SpeedDownTimer
onready var tail = preload("res://Player/tail.tscn")

# Exported variables for easy testing
export var movement_speed = 0.2
export var speedup_time = 5
export var speedup_speed = 0.1
export var speeddown_time = 5
export var speeddown_speed = 0.5


# Head and tail scenes
var head_asset = preload("res://Player/head.tscn")
var tail_asset = preload("res://Player/tail.tscn")

# Array of body parts (heads and tails)
var player_body = []
# The current movement direction (starts of going right)
var direction = Global.PLAYER_DIRECTIONS["right"]
# The previous movement direction
var prevDirection = Global.PLAYER_DIRECTIONS["right"]


func _ready():
	# Reset points and point modifier
	PointSystem.reset_point_modifier()
	PointSystem.reset_points()
	
	# Get starting position
	update_player_start()
	
	# Set up player movement speed
	movement_timer.wait_time = movement_speed


# Handles direction input
func _unhandled_input(event):
	for dir in Global.PLAYER_DIRECTIONS.keys():
		if event.is_action_pressed(dir):
			var newDirection = Global.PLAYER_DIRECTIONS[dir]
			# If the new direction doesn't make the player go back into itself
			if (newDirection != -direction and newDirection != -prevDirection):
				direction = newDirection


# Sets up the player character
func update_player_start():
	# Instance the head and two tails
	var head = head_asset.instance()
	var tail1 = tail_asset.instance()
	var tail2 = tail_asset.instance()
	# Set up interactions with powerups
	head.connect("consumed_point_powerup", self, "add_tail")
	head.connect("speed_powerup", self, "plus_speed")
	head.connect("speed_powerdown", self, "minus_speed")
	head.connect("magnet_powerup", self, "magnet_powerup")
	head.connect("half_powerup", self, "half_powerup")
	
	# Add head and tails to the player scene
	get_tree().get_root().get_node("TestLevel").get_node("Player").add_child(head)
	get_tree().get_root().get_node("TestLevel").get_node("Player").add_child(tail1)
	get_tree().get_root().get_node("TestLevel").get_node("Player").add_child(tail2)
	
	# Add head and tails to the player_body array
	player_body.push_back(head)
	player_body.push_back(tail1)
	player_body.push_back(tail2)
	
	# Set starting positions for head and tails
	var index = 0
	for player_segment in player_body:
		player_body[index].position = Vector2(Global.CELL_SIZE * (Global.BOARD_WIDTH / 2 - index) + Global.OFFSET, 
											Global.CELL_SIZE * (Global.BOARD_HEIGHT / 2) + Global.OFFSET)
		index += 1


func move_player():
	# Pop last tail
	var last_tail = player_body.pop_back()
	
	# Remove head
	var new_head = player_body.pop_front()
	var previous_head_pos = new_head.position
	
	# Put removed tail in previous head position
	player_body.push_front(last_tail)
	last_tail.position = previous_head_pos
	
	# Push front new head with old_position + direction
	player_body.push_front(new_head)
	new_head.position = previous_head_pos+ direction * Global.CELL_SIZE
	
	# Orient the new head if needed
	orient_head(new_head)
	
	
	prevDirection = direction


# Orient's the head based on current direction
func orient_head(new_head):
	if direction == Global.PLAYER_DIRECTIONS["up"]:
		new_head.get_node("HeadSprite").rotation_degrees = 270
	elif direction == Global.PLAYER_DIRECTIONS["down"]:
		new_head.get_node("HeadSprite").rotation_degrees = 90
	elif direction == Global.PLAYER_DIRECTIONS["left"]:
		new_head.get_node("HeadSprite").rotation_degrees = 180
	elif direction == Global.PLAYER_DIRECTIONS["right"]:
		new_head.get_node("HeadSprite").rotation_degrees = 0


# Adds a new tail to the player
func add_tail():
	# Create new tail
	var new_tail = tail_asset.instance()
	
	# Put it's position in the player's rear
	new_tail.position = player_body[player_body.size()- 1].position
	
	# Add to the player node
	get_tree().get_root().get_node("TestLevel").get_node("Player").add_child(new_tail)
	
	# Put tail in body array
	player_body.push_back(new_tail)
	
	# Add a point to the player
	PointSystem.add_point()


# Speeds up the player for X seconds
func plus_speed():
	movement_timer.wait_time = speedup_speed
	# start timer to get speed back to original value
	speedup_timer.start(speedup_time)
	# Add to the point modifier
	PointSystem.change_point_modifier(2)


# Slows down the player for X seconds
func minus_speed():
	movement_timer.wait_time = speeddown_speed
	# start timer to get speed back to original value
	speed_down_timer.start(speeddown_time)


# Turns the player's head into a magnet
func magnet_powerup():
	pass


# Cuts the player's size in half
func half_powerup():
	pass


# Move the player
func _on_MovementTimer_timeout():
	move_player()


# Reset player speed
func _on_SpeedupTimer_timeout():
	movement_timer.wait_time = movement_speed
	PointSystem.reset_point_modifier()


# Reset player speed
func _on_SpeedDownTimer_timeout():
	movement_timer.wait_time = movement_speed


# Remove magnet property
func _on_MagnetTimer_timeout():
	pass
