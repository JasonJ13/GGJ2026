extends Control
class_name Monster

var app : Control

var location : Room
var chance_to_move : int = 50

@export var in_menu : bool = false

enum Mask {CONTINUE, CUTE, DANGER, FLEE, STAY}
@export var mask : Mask
@onready var textureMask : Array[Node] = $Head.get_children()

@onready var timerRespawn : Timer = $Respawn

signal is_huged


func _ready() -> void:
	if in_menu :
		$SwitchMask.play("Maskswitch")

func get_location() -> Room :
	return location

func defineApp(a : Control) -> void :
	app = a

func mouvementOpportunity() -> void :
	var chance = randi() % 100
	if chance < chance_to_move :
		opportunity()

func opportunity() -> void:
	var resultMonsterToPlayer : Array = app.monsterToPlayer()
	var nmbRoom : int = resultMonsterToPlayer[0]
	var toTheLeft : bool = resultMonsterToPlayer[1]

	if nmbRoom == 1 :
		var chance = randi() % 100
		
		if chance < 25 :
			move(toTheLeft)
		else : 
			return


	else :
		var nmbMovement = (randi() % (nmbRoom-1) ) + 1
		
		for i in range(nmbMovement) :
			move(toTheLeft)
	app.monsterMoved()

func move(left : bool) :
	if left :
		location = location.get_left_room()
	else :
		location = location.get_right_room()

func disepear() :
	location = null

func relocate() :
	change_mask()
	
	if app.get_currentRoom() != app.get_firstRoom() :
		location = app.get_firstRoom()
	else :
		location = app.get_middleRoom()
	

func get_Mask() -> Mask :
	return mask

func change_mask(new_mask : int = -1) -> void :
	if new_mask == -1 :
		new_mask = randi() % 4
		mask = (new_mask + int(new_mask >= mask)) as Mask
	else :
		mask = new_mask as Mask
	
	textureMask.map(func(t) : t.hide())
	textureMask[mask].show()


func huged() -> void:
	is_huged.emit()
