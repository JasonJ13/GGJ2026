extends Control
class_name Room

var position_losts : Vector2

var left_room : Room
var right_room : Room

signal grab_signal(lost:Lost)
signal place_signal(found:Found)

func set_left_room(lRoom : Room) -> void:
	left_room = lRoom

func get_left_room() -> Room:
	return left_room
	
func set_right_room(rRoom : Room) :
	right_room = rRoom

func get_right_room() -> Room:
	return right_room

func _to_string() -> String:
	return "Salle : " + self.name

func found_clicked(found: Found) -> void:
	print("chek room found place ", str(self))
	place_signal.emit(found)

func lost_clicke(lost : Lost) -> void :
	print("chek room lost grab", str(self))
	grab_signal.emit(lost)
	self.remove_child(lost)
