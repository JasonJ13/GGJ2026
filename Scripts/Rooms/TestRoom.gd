"""
Salle de test
Salle suivante : Salle de test
Salle précédente : Salle de test
"""

extends Room



func _init() -> void:
	name_room = "Test Room "
	set_left_room(self)
	set_right_room(self)

func set_num(num : int) :
	name_room = name_room + str(num)
