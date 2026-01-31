extends Control

@export var isdebug : bool = true

@onready var animationTree : AnimationTree = $AnimationTree
@onready var animationMode = animationTree.get("parameters/playback")

@export var nmbRoom : int = 4
var currentRoom : Room
var testRoomRess : Resource
var onIdle : bool = true
var comeFromRight : bool = true

func get_current_room() -> Room :
	return currentRoom

var monsterRess : Resource = preload("res://Scenes/Monster/Monster.tscn")
var monster : Monster
var monsterIsPresent : bool = false
var monsterIsIn : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	monster = monsterRess.instantiate()
	monster.defineApp(self)
	
	if isdebug :
		testRoomRess = preload("res://Scenes/Rooms/TestRoom.tscn")
		
		var prevRoom : Room = null
		var firstRoom : Room = null
		for i in range(nmbRoom) :
			var newRoom : Room = testRoomRess.instantiate()
			newRoom.set_num(i)
			if prevRoom != null :
				newRoom.set_left_room(prevRoom)
				newRoom.get_left_room().set_right_room(newRoom)
			else :
				firstRoom = newRoom
			
			prevRoom = newRoom
			
			@warning_ignore("integer_division")
			if i == nmbRoom/2 :
				monster.location = newRoom
			
			elif i == nmbRoom -1 :
				newRoom.set_right_room(firstRoom)
				firstRoom.set_left_room(newRoom)
		
		enter_room(firstRoom, false)
		monsterIsPresent = true


### Gestion du changement de salle
func enter_room(new_room : Room, not_first_room = true) -> void:
	print(new_room)
	if not_first_room :
		self.remove_child(currentRoom)
	
	currentRoom = new_room
	self.add_child(currentRoom)
	onIdle = true
	
	if monster.location == currentRoom :
		Encounter()


func enter_left_room() -> void :
	
	if monsterIsIn :
		if comeFromRight :
			react(Reaction.FLEE)
		else :
			react(Reaction.CONTINUE)
	
	else :
		onIdle = false
		animationMode.travel("FadeOutToLeft")
	
func enter_right_room() -> void :
	
	if monsterIsIn :
		if comeFromRight :
			react(Reaction.CONTINUE)
		else :
			react(Reaction.FLEE)
	
	else :
		onIdle = false
		animationMode.travel("FadeOutToRight")

func new_left_room() -> void :
	comeFromRight = false
	enter_room(currentRoom.get_left_room())

func new_right_room() -> void :
	comeFromRight = true
	enter_room(currentRoom.get_right_room())



### Gestion du monstre

var cooldownMonster : int = 120
var timerMonsterMouvement : int = 0

enum Reaction {CONTINUE,HUG,FLEE}

## Mouvement du Monstre


@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	
	if monsterIsPresent :
		timerMonsterMouvement += 1
		
		if (onIdle && !monsterIsIn && cooldownMonster < timerMonsterMouvement) :
			monster.mouvementOpportunity()
			timerMonsterMouvement = 0

func monsterToPlayer() -> Array :
	
	var roomAct : Room= monster.get_location()
	var nmbRoomTravel : int = 0
	
	while roomAct != currentRoom :
		roomAct = roomAct.get_left_room()
		nmbRoomTravel += 1
		
	@warning_ignore("integer_division")
	if nmbRoomTravel <= nmbRoom/2 :
		return [nmbRoomTravel,true]
	else :
		return [nmbRoom-nmbRoomTravel, false]
	
func monsterMoved() -> void :
	if monster.get_location() == currentRoom :
		Encounter()


##Gestion de la rencontre

@onready var timerMonsterKill : Timer = $KillTimer

func Encounter() -> void:
	monsterIsIn = true
	self.add_child(monster)
	if monster.get_Mask() == Monster.Mask.DANGER :
		print("take one hint")
	else :
		timerMonsterKill.start()
		print("wait for reaction")

func react(reaction : Reaction) -> void :
	match [reaction, monster.get_Mask()] :
		[Reaction.FLEE, Monster.Mask.FLEE], [Reaction.CONTINUE, Monster.Mask.CONTINUE] :
			survive()
		_ :
			die()

func survive() -> void :
	print("you survived")
	#monster.relocate()

func die() -> void :
	print("you die")
