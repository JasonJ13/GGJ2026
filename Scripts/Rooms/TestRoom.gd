"""
Salle de test
Salle suivante : Salle de test
Salle précédente : Salle de test
"""

extends Room



# Called when the node enters the scene tree for the first time.


func _init() -> void:
	set_left_room(self)
	set_right_room(self)

func set_num(num : int) :
	name = name + str(num)
	
func _on_lost_test_grab_signal(lost : Lost) -> void:
	print("chek room lost grab")
	self.remove_child(lost)
	grab_signal.emit(lost)
