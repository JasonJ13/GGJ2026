extends Control

@export var debug : bool = true

var testRoom : Resource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if debug :
		testRoom = preload("res://Scenes/Room/TestRoom.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
