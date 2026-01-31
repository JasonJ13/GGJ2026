extends Control
class_name Monster

var app : Control

var location : Room
var chance_to_move : int = 50

var mask : Mask

func get_location() -> Room :
	return location

func defineApp(a : Control) -> void :
	app = a

func mouvementOpportunity() -> void :
	var chance = randi() % 100
	print("opportunity : " + str(chance))
	if chance < chance_to_move :
		opportunity()

func opportunity() -> void:
	var resultMonsterToPlayer : Array = app.monsterToPlayer()
	var nmbRoom : int = resultMonsterToPlayer[0]
	var toTheLeft : bool = resultMonsterToPlayer[1]

	if nmbRoom == 1 :
		move(toTheLeft)

	else :
		var nmbMovement = (randi() % (nmbRoom-1) ) + 1
		
		for i in range(nmbMovement) :
			move(toTheLeft)

	print(location)
	app.monsterMoved()

func move(left : bool) :
	if left :
		location = location.get_left_room()
	else :
		location = location.get_right_room()
