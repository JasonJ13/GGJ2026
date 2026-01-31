"""
Salle de test
Salle suivante : Salle de test
Salle précédente : Salle de test
"""

extends Room



func _ready() -> void:
	name_room = "Test Room"
	set_left_room(self)
	set_right_room(self)
