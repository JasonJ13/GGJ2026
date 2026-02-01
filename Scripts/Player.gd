extends Control
class_name Player

signal left
signal right
signal object_associated

var backpack: Array [Lost]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_left_button_pressed() -> void:
	left.emit()

func _on_right_button_pressed() -> void:
	right.emit()

func add_to_backpack(lost:Lost) -> void:
	print("add to backpack")
	backpack.append(lost)

func check_lost(found : Found) -> void :
	print(found.lost_associate)
	print(backpack)
	if found.lost_associate in backpack :
		backpack.erase(found.lost_associate)
		#found.lost_associate.show()
		found.hide()
		print("has been placed " + str(found.lost_associate))
		

func lostHint() -> bool :
	if backpack.is_empty() :
		return false
	
	else :
		backpack.pop_front()
		return true
