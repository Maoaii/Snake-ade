extends Area2D

signal magnet_pickup
signal move_magnet

onready var death_timer = $DeathTimer
export var death_time = 10


func _ready():
	death_timer.start(death_time)


func _on_DeathTimer_timeout():
	Global.has_magnet = false
	queue_free()


func _on_Magnet_area_entered(area):
	if area.name == "PointPowerup":
		emit_signal("magnet_pickup")


func _on_MovementTimer_timeout():
	emit_signal("move_magnet", self)
