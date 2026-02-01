extends Control

## Pour utiliser les salles tests
@export var debugRoom : bool = false

@onready var player : Player = $Player
@onready var animationTree : AnimationTree = $AnimationTree
@onready var animationMode = animationTree.get("parameters/playback")

## Définir le nombre de salle ! modifie le nombre de salle que dans le cas du Debug Room
@export var nmbRoom : int = 4
var currentRoom : Room
var firstRoom : Room
var middleRoom : Room
var testRoomRess : Resource
var onIdle : bool = true
var comeFromRight : bool = true

func get_current_room() -> Room :
	return currentRoom

## Pour désactiver le monstre
@export var debug_Monster = true
var monsterRess : Resource = preload("res://Scenes/Monster/Monster.tscn")
var monster : Monster
var monsterIsPresent : bool = false
var monsterIsIn : bool = false

func get_nmbRoom() -> int :
	return nmbRoom

func get_currentRoom() -> Room :
	return currentRoom

func get_firstRoom() -> Room :
	return firstRoom

func get_middleRoom() -> Room :
	return middleRoom


func _ready() -> void:
	
	monster = monsterRess.instantiate()
	monster.defineApp(self)
	
	
	if debugRoom :
		testRoomRess = preload("res://Scenes/Rooms/TestRoom.tscn")
		
		var prevRoom : Room = null
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
				middleRoom = newRoom
			
			if i == nmbRoom -1 :
				newRoom.set_right_room(firstRoom)
				firstRoom.set_left_room(newRoom)
		
		enter_room(firstRoom, false)
		monsterIsPresent = true
	
	else :
		var attic : Room = load("res://Scenes/Rooms/Attic.tscn").instantiate()
		var bedroom : Room = load("res://Scenes/Rooms/Bedroom.tscn").instantiate()
		var livingroom : Room = load("res://Scenes/Rooms/Livingroom.tscn").instantiate()
		var kitchen : Room = load("res://Scenes/Rooms/Kitchen.tscn").instantiate()
		
		attic.set_right_room(bedroom)
		bedroom.set_right_room(livingroom)
		livingroom.set_right_room(kitchen)
		kitchen.set_right_room(attic)
		
		attic.set_left_room(kitchen)
		kitchen.set_left_room(livingroom)
		livingroom.set_left_room(bedroom)
		bedroom.set_left_room(attic)
		
		attic.place_signal.connect(place_found)
		kitchen.place_signal.connect(place_found)
		livingroom.place_signal.connect(place_found)
		bedroom.place_signal.connect(place_found)
		
		bedroom.grab_signal.connect(grab_lost)
		kitchen.grab_signal.connect(grab_lost)
		livingroom.grab_signal.connect(grab_lost)
		attic.grab_signal.connect(grab_lost)
		
		enter_room(attic, false)
		
		firstRoom = attic
		middleRoom = livingroom
		
		if debug_Monster :
			monster.connect("is_huged",react.bind(Reaction.HUG))
			monster.location = livingroom
			monsterIsPresent = true


#region Gestion du changement de salle
func enter_room(new_room : Room, not_first_room = true) -> void:
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
		animationTree.set("parameters/conditions/GoLeft",true)
	
func enter_right_room() -> void :
	
	if monsterIsIn :
		if comeFromRight :
			react(Reaction.CONTINUE)
		else :
			react(Reaction.FLEE)
	
	else :
		onIdle = false
		animationTree.set("parameters/conditions/GoRight",true)

func new_left_room() -> void :
	animationTree.set("parameters/conditions/GoLeft",false)
	comeFromRight = false
	enter_room(currentRoom.get_left_room())

func new_right_room() -> void :
	animationTree.set("parameters/conditions/GoRight",false)
	comeFromRight = true
	enter_room(currentRoom.get_right_room())



#region Gestion du monstre

var cooldownMonster : int = 120
var timerMonsterMouvement : int = 0

enum Reaction {CONTINUE, HUG, FLEE, STAY, STOLEN}


#region Mouvement du Monstre

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	
	if monsterIsPresent && !monsterIsIn :
		if (onIdle  && cooldownMonster < timerMonsterMouvement) :
			monster.mouvementOpportunity()
			timerMonsterMouvement = 0
		
		else :
			timerMonsterMouvement += 1

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


#region de la rencontre

@onready var timerMonsterKill : Timer = $KillTimer
@onready var timerMonsterRespawn : Timer = $RespawnTimer

signal player_died

func Encounter() -> void:
	monsterIsIn = true
	monsterIsPresent = false
	
	animationTree.set("parameters/conditions/MonsterIsOut",false)
	animationTree.set("parameters/conditions/MonsterIsIn",true)
	
	self.add_child(monster)
	
	timerMonsterKill.start(0)
	print("wait for reaction")

func react(reaction : Reaction) -> void :
	monsterIsIn = false
	timerMonsterKill.stop()
	animationTree.set("parameters/conditions/MonsterIsIn",false)
	animationTree.set("parameters/conditions/MonsterIsOut",true)
	match [reaction, monster.get_Mask()] :
		[Reaction.FLEE, Monster.Mask.FLEE]  :
			if comeFromRight :
				enter_left_room()
			else :
				enter_right_room()
			survive(false)
		
		[Reaction.CONTINUE, Monster.Mask.CONTINUE] :
			if comeFromRight :
				enter_right_room()
			else :
				enter_left_room()
			survive(false)
		
		[Reaction.HUG, Monster.Mask.CUTE], [Reaction.STAY, Monster.Mask.STAY], [Reaction.STOLEN,Monster.Mask.DANGER] :
			survive(true)
			
		_ :
			die()

func survive(stay : bool) -> void :
	if stay :
		animationTree.set("parameters/conditions/Stay",true)
	
	animationTree.set("parameters/conditions/MonsterIsIn",false)
	animationTree.set("parameters/conditions/MonsterIsOut",true)
	print("you survived")
	remove_child(monster)
	monster.disepear()
	timerMonsterRespawn.start()


func die() -> void :
	print("you die")
	player_died.emit()
	process_mode = Node.PROCESS_MODE_PAUSABLE
	process_mode = Node.PROCESS_MODE_DISABLED
	

func relocateMonster() -> void:
	
	
	
	monster.relocate()
	print("relocate " + str(monster.location))
	timerMonsterMouvement = 0
	monsterIsPresent = true



#region Gestion des Losts&Founds

func grab_lost(lost:Lost) -> void:
	print("app chek lost grab " + str(lost))
	player.add_to_backpack(lost)


func place_found(found: Found) -> void:
	print("app chek found place " + str(found))
	player.check_lost(found)

func player_give_lost() -> void:
	if monsterIsIn :
		if player.lostHint() :
			react(Reaction.STOLEN)
