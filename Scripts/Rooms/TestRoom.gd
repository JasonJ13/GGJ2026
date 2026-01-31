"""
Salle de test
Salle suivante : Salle de test
Salle précédente : Salle de test
"""

extends Room
@onready var lost_test_child: Control = $LostTest

func _ready() -> void:
	lost_test_child.grab_signal.connect(_on_lost_test_grab_signal)

func _init() -> void:
	name_room = "Test Room "
	set_left_room(self)
	set_right_room(self)

func set_num(num : int) :
	name_room = name_room + str(num)
	
func _on_lost_test_grab_signal() -> void:
	print("chek room lost grab")
	self.remove_child(lost_test_child)
