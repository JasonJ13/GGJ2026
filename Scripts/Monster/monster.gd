extends Control
class_name Monster

var app : Control

var location : Room
var chance_to_move : int = 50

enum Mask {CONTINUE, CUTE, DANGER, FLEE, STAY}
var mask : Mask = Mask.FLEE

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
		var chance = randi() % 100
		
		if chance < 25 :
			move(toTheLeft)
		else : 
			return

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


func get_Mask() -> Mask :
	return mask
