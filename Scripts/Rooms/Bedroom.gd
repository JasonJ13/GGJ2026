extends Room


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	name_room = "bedroom"

func get_lost_test() -> Lost :
	return $LostTest
