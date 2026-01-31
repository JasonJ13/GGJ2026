extends Control
class_name Room

var name_room : String

var left_room : Room
var right_room : Room

func set_left_room(lRoom : Room) -> void:
	left_room = lRoom

func get_left_room() -> Room:
	return left_room
	
func set_right_room(rRoom : Room) :
	right_room = rRoom

func get_right_room() -> Room:
	return right_room

func _to_string() -> String:
	return "Salle : " + name_room
