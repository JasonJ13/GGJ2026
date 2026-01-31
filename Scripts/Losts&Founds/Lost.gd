extends Control
class_name Lost

var found_associate:Found
var isLost = true

var nameLost : String = "name not gived"


func _to_string() -> String:
	return "Lost : " + nameLost
