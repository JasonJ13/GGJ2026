extends Control

@export var isdebug : bool = true

var testRoom : Resource

var currentRoom : Room

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if isdebug :
		testRoom = preload("res://Scenes/Room/TestRoom.tscn")
		
		enter_room(testRoom.instantiate(), false)

func enter_room(new_room : Room, not_first_room = true) -> void:
	if not_first_room :
		self.remove_child(currentRoom)
	
	currentRoom = new_room
	add_child(currentRoom)
	print(currentRoom)

func enter_left_room() -> void :
	enter_room(currentRoom.get_left_room())
	
func enter_right_room() -> void :
	enter_room(currentRoom.get_right_room())
	
	
