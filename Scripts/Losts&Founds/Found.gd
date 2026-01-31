extends Control
class_name Found

@export var lost_associate: Lost

signal place_signal(found:Found)

var nameFound : String = "name not gived"

func associate(l_associate : Lost) -> void:
	lost_associate = l_associate 
	lost_associate.found_associate = self

func _to_string() -> String:
	return "Found : " + nameFound


func _on_button_pressed() -> void:
	place_signal.emit(self)
