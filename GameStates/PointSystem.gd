extends Node


# Point system
var points = 0
var point_modifier = 1

func add_point():
	points = points + 1 * point_modifier

func reset_points():
	points = 0

func change_point_modifier(value):
	point_modifier = value


func reset_point_modifier():
	point_modifier = 1
