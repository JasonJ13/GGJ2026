"""
Salle de test
Salle suivante : Salle de test
Salle précédente : Salle de test
"""

extends Room
@onready var lost_test_child: Control = $LostTest
@onready var found_test_child: Control = $FoundTest



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var foundtest : Found = $FoundTest
	var losttest : Lost = $LostTest
	
	print(foundtest)
	print(losttest)
	
	foundtest.associate(losttest)

func _init() -> void:
	name_room = "Test Room "
	set_left_room(self)
	set_right_room(self)

func set_num(num : int) :
	name_room = name_room + str(num)
	
func _on_lost_test_grab_signal(lost : Lost) -> void:
	print("chek room lost grab")
	self.remove_child(lost)
	grab_signal.emit(lost)


	
func object_associated() -> void:
	self.remove_child(found_test_child)
	self.add_child(lost_test_child)
