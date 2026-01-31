extends Found
signal place_signal(found:Found)



# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _init() -> void:
	nameFound = "test found"

func _on_button_pressed() -> void:
	print("found clic")
	place_signal.emit(self)
