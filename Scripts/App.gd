extends Control

@export var isdebug : bool = true

@onready var animationTree : AnimationTree = $AnimationTree
@onready var animationMode = animationTree.get("parameters/playback")

var currentRoom : Room
var testRoomRess : Resource
var onMouvement : bool = false

var MonsterLocation : Room
@export var MonsterCooldown : int
var MonsterTimer : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if isdebug :
		testRoomRess = preload("res://Scenes/Room/TestRoom.tscn")
		
		var testRoom1 = testRoomRess.instantiate()
		testRoom1.set_num(1)
		var testRoom2 = testRoomRess.instantiate()
		testRoom2.set_num(2)
		testRoom1.set_right_room(testRoom2)
		testRoom2.set_left_room(testRoom1)
		var testRoom3 = testRoomRess.instantiate()
		testRoom3.set_num(3)
		testRoom2.set_right_room(testRoom3)
		testRoom3.set_left_room(testRoom2)
		var testRoom4 = testRoomRess.instantiate()
		testRoom4.set_num(4)
		testRoom3.set_right_room(testRoom4)
		testRoom4.set_left_room(testRoom3)
		testRoom4.set_right_room(testRoom1)
		testRoom1.set_left_room(testRoom4)
		
		enter_room(testRoom1, false)

func enter_room(new_room : Room, not_first_room = true) -> void:
	onMouvement = true
	print(new_room)
	if not_first_room :
		self.remove_child(currentRoom)
	
	currentRoom = new_room
	add_child(currentRoom)




func enter_left_room() -> void :
	animationMode.travel("FadeOutToLeft")
	enter_room(currentRoom.get_left_room())
	
func enter_right_room() -> void :
	animationMode.travel("FadeOutToRight")
	enter_room(currentRoom.get_right_room())
	
func new_room() -> void :
	print("enter a new room")
