extends Node

# Board size
const BOARD_WIDTH = 16
const BOARD_HEIGHT = 16

# Cell size
const CELL_SIZE = 32

# Offset to draw sprites
const OFFSET = 16

# Dictionary of point consumable skins
const POINT_CONSUMABLE_SKINS = {
	"snake": "res://Assets/Player/Snake/point_powerup.png",
	"slug": "res://Assets/Player/Slug/point_powerup.png",
}

# Dictionary of consumables
const CONSUMABLES = {
	0: preload("res://Consumables/SpeedPowerdown.tscn"),
	1: preload("res://Consumables/MagnetPowerup.tscn"),
	2: preload("res://Consumables/HalfPowerup.tscn"),
}
const POINT_CONSUMABLE_ASSET = preload("res://Consumables/PointPowerup.tscn")

# Dictionary of player skins
const PLAYER_HEAD_SKINS = {
	"snake": "res://Assets/Player/Snake/snake_head.png",
	"slug": "res://Assets/Player/Slug/slug_head.png",
}

# Dictionary of player skins
const PLAYER_TAIL_SKINS = {
	"snake": "res://Assets/Player/Snake/snake_tail.png",
	"slug": "res://Assets/Player/Slug/slug_tail.png",
}


# Dictionary of player input
const PLAYER_DIRECTIONS = {
	"up": Vector2.UP,
	"down": Vector2.DOWN,
	"left": Vector2.LEFT,
	"right": Vector2.RIGHT,
}

