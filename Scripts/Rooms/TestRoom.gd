"""
Salle de test
Salle suivante : Salle de test
Salle précédente : Salle de test
"""

extends Room
@onready var lost_test_child: Control = $LostTest
@onready var found_test_child: Control = $FoundTest

signal grab_signal(lost:Lost)

func _ready() -> void:
	pass

func _init() -> void:
	name_room = "Test Room "
	set_left_room(self)
	set_right_room(self)

func set_num(num : int) :
	name_room = name_room + str(num)
	
func _on_lost_test_grab_signal(lost : Lost) -> void:
	print("chek room lost grab")
	self.remove_child(lost_test_child)
	grab_signal.emit(lost)


func _on_found_test_place_signal() -> void:
	print("chek room found place")
	self.remove_child(found_test_child)
	self.add_child(lost_test_child)
