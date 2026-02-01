extends Found




# Called when the node enters the scene tree for the first time.



func _on_button_pressed() -> void:
	print("found clic")
	place_signal.emit(self)
