extends Control
class_name Room

var next_room : Room
var prev_room : Room

func set_next_room(nRoom : Room) -> void:
	next_room = nRoom

func get_next_room() -> Room:
	return next_room
	
func set_prev_room(pRoom : Room) :
	prev_room = pRoom

func get_prev_room() -> Room:
	return prev_room
