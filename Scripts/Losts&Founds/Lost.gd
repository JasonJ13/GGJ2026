extends Control
class_name Lost

@export var found_associate:Found
var isLost = false

signal grab_signal(found:Found)

var nameLost : String = "name not gived"

func _on_button_pressed() -> void:
	if isLost :
		grab_signal.emit(self)


func _to_string() -> String:
	return "Lost : " + nameLost
