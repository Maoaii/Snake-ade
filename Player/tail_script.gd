extends Area2D

func _ready():
	# Set up tail skin
	find_node("TailSprite").texture = SkinSystem.current_tail
