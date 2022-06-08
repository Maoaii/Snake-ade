extends Node2D

# Exported variables for easy testing
export var min_consumable_spawn_time = 5
export var max_consumable_spawn_time = 10

onready var consumable_spawner = $ConsumableSpawner

var point_consumable
var consumables = []


func _ready():
	# Randomize randon number generator
	randomize()
	
	# Create point consumable
	create_point_consumable()


func create_point_consumable():
	# Instance point consumable
	point_consumable = Global.POINT_CONSUMABLE_ASSET.instance()
	
	# Add point consumable to tree
	get_tree().get_root().get_node("TestLevel").get_node("Consumables").add_child(point_consumable)

# Create a random consumable
func _on_ConsumableSpawner_timeout():
	# Get a reandom consumable and instance it
	var powerup_instance = Global.CONSUMABLES[randi() % Global.CONSUMABLES.size()].instance()
	# Give it a random position
	while true:
		powerup_instance.position = get_random_pos()
		if powerup_instance.position != point_consumable.position:
			break
	# Append to consumables array
	consumables.append(powerup_instance)
	# Add as a child of consumables scene
	get_tree().get_root().get_node("TestLevel").get_node("Consumables").add_child(powerup_instance)
	# Start the consumable spawner at a random time
	consumable_spawner.start(randi() % max_consumable_spawn_time + min_consumable_spawn_time)

# Gets a random position in the board
func get_random_pos():
	return Vector2(((randi() % Global.BOARD_WIDTH) * Global.CELL_SIZE) + Global.OFFSET,
				  ((randi() % Global.BOARD_HEIGHT) * Global.CELL_SIZE) + Global.OFFSET)
