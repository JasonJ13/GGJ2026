extends Control
class_name Found

@export var lost_associate: Lost
@export var texture_associate : TextureRect


signal place_signal(found:Found)

func _ready() -> void :
	$Button.flat = true

func associate(l_associate : Lost) -> void:
	lost_associate = l_associate 
	lost_associate.found_associate = self

func _to_string() -> String:
	return "Found : " + self.name


func _on_button_pressed() -> void:
	print(self)
	place_signal.emit(self)

func replace() :
	hide()
	texture_associate.show()
