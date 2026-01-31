extends Control

@onready var test_room: Control = $TestRoom
@onready var player = $Player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_test_room_grab_signal(lost:Lost) -> void:
	print("app chek lost grab")
	player.add_to_backpack(lost)


func _on_test_room_place_signal(found: Found) -> void:
	print("app chek found place")
	player.check_lost(found)


func _on_player_object_associated() -> void:
	$TestRoom.object_associated
	
	
