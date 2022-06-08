extends Node


# Point system
var points = 0 setget set_highscore
var point_modifier = 1

func add_point():
	points = points + 1 * point_modifier

func reset_points():
	points = 0

func change_point_modifier(value):
	point_modifier = value

func reset_point_modifier():
	point_modifier = 1

func set_highscore(new_highscore):
	if points > Highscore.highscore:
		Highscore.highscore = points
