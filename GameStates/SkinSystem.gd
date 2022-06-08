extends Node


# Current snake skin
var current_head = load(Global.PLAYER_HEAD_SKINS["snake"])
var current_tail = load(Global.PLAYER_TAIL_SKINS["snake"])
var current_point_consumable = load(Global.POINT_CONSUMABLE_SKINS["snake"])

# Changes the skin
func change_skin(new_skin):
	current_head = load(Global.PLAYER_HEAD_SKINS[new_skin])
	current_tail = load(Global.PLAYER_TAIL_SKINS[new_skin])
	current_point_consumable = load(Global.POINT_CONSUMABLE_SKINS[new_skin])


