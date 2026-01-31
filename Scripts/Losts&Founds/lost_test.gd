extends Lost
signal grab_signal(lost : Lost)



func _init() -> void:
	nameLost = "test lost"

func _on_button_pressed() -> void:
	if isLost :
		print("lost grab")
		grab_signal.emit(self)
