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


@export var losts : Array[Lost]
@export var nmb_losts : int

func get_random_lost() -> Lost :
	print(losts)
	print(nmb_losts)
	var chance : int = randi() % nmb_losts
	
	var lost = losts[chance]
	
	lost.found_associate.texture_associate.hide()
	
	return lost

@export var posLosts : Array[Vector2]
@export var nmb_posLosts : int

func set_random_pos_lost(lost : Lost) -> void :
	add_child(lost)
	
	lost.show()
	lost.isLost = true
	
	lost.position = posLosts[randi() % nmb_posLosts]
