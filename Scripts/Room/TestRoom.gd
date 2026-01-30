"""
Salle de test
Salle suivante : Salle de test
Salle précédente : Salle de test
"""

extends Room



func _ready() -> void:
	set_next_room(self)
	set_prev_room(self)
