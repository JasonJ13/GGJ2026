@tool
extends Control
class_name Lost

@export var found_associate : Found
var isLost = false

@export var button_icon: Texture2D :
	set(texture):
		button_icon = texture
		$Button.icon = texture
		

signal grab_signal(found:Found)

func _on_button_pressed() -> void:
	if isLost :
		grab_signal.emit(self)


func _to_string() -> String:
	return "Lost : " + self.name
