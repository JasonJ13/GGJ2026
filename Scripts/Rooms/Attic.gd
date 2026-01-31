extends Room


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	name_room = "attic"

func get_found_test() -> Found :
	return $FoundTest

var pos1: Vector2 = Vector2(277.0,515.0)
var pos2:Vector2 = Vector2(796.0,240.0)
var poos3:Vector2 = Vector2(897.0,514.0)
