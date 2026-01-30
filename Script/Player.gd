extends Control

signal left
signal right

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_left_button_pressed() -> void:
	print("gauche")
	left.emit()


func _on_right_button_pressed() -> void:
	print("droite")
	right.emit()
