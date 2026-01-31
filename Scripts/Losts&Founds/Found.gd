extends Control
class_name Found

var lost_associate: Lost

var nameFound : String = "name not gived"

func associate(l_associate : Lost) -> void:
	lost_associate = l_associate 
	lost_associate.found_associate = self

func _to_string() -> String:
	return "Found : " + nameFound
