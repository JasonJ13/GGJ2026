extends Control

@export var isdebug : bool = true

@onready var animationTree : AnimationTree = $AnimationTree
@onready var animationMode = animationTree.get("parameters/playback")

@export var nmbRoom : int = 4
var currentRoom : Room
var testRoomRess : Resource
var onIdle : bool = true

func get_current_room() -> Room :
	return currentRoom

var monsterRess : Resource = preload("res://Scenes/Monster/Monster.tscn")
var monster : Monster
var monsterIsPresent : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	monster = monsterRess.instantiate()
	monster.defineApp(self)
	
	if isdebug :
		testRoomRess = preload("res://Scenes/Rooms/TestRoom.tscn")
		
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
		monster.location = testRoom3
		monsterIsPresent = true

func enter_room(new_room : Room, not_first_room = true) -> void:
	print(new_room)
	if not_first_room :
		self.remove_child(currentRoom)
	
	currentRoom = new_room
	self.add_child(currentRoom)
	onIdle = true




func enter_left_room() -> void :
	onIdle = false
	animationMode.travel("FadeOutToLeft")
	
func enter_right_room() -> void :
	onIdle = false
	animationMode.travel("FadeOutToRight")

func new_left_room() -> void :
	enter_room(currentRoom.get_left_room())

func new_right_room() -> void :
	enter_room(currentRoom.get_right_room())


var cooldownMonster : int = 120
var timerMonster : int = 0

func _process(delta: float) -> void:
	
	if monsterIsPresent :
		timerMonster += 1
		
		if (onIdle && cooldownMonster < timerMonster) :
			monster.mouvementOpportunity()
			timerMonster = 0

func monsterToPlayer() -> Array :
	
	var roomAct : Room= monster.get_location()
	var nmbRoomTravel : int = 0
	
	while roomAct != currentRoom :
		roomAct = roomAct.get_left_room()
		nmbRoomTravel += 1
		
	if nmbRoomTravel <= nmbRoom/2 :
		return [nmbRoomTravel,true]
	else :
		return [nmbRoom-nmbRoomTravel, false]
	
func monsterMoved() -> void :
	if monster.get_location() == currentRoom :
		self.add_child(monster)
