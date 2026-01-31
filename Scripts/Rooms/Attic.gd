extends Room


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	name_room = "attic"

func get_found_test() -> Found :
	return $FoundTest
