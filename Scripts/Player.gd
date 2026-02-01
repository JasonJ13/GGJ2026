extends Control
class_name Player

signal left
signal right
signal give_lost

var backpack: Array [Lost]

var score : int = 0

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
		
		score += 1
		

func lostHint() -> bool :
	return true
	if backpack.is_empty() :
		return false
	
	else :
		backpack.pop_front()
		return true


func _on_lost_case_pressed() -> void:
	give_lost.emit()
