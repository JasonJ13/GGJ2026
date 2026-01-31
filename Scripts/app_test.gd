extends Node2D

@onready var test_room: Control = $TestRoom
signal grab_signal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_test_room_grab_signal() -> void:
	print("app chek lost grab")
	grab_signal.emit()
