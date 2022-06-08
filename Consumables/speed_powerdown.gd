extends Area2D

onready var death_timer = $DeathTimer
export var min_death_timer = 5
export var max_death_timer = 10

func _ready():
	randomize()
	death_timer.start(randi() % max_death_timer + min_death_timer)


func _on_DeathTimer_timeout():
	queue_free()
