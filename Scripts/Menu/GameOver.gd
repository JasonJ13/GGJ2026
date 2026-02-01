extends Control


signal retry
signal mainMenu

@onready var animation : AnimationPlayer = $AnimationPlayer

func press_Retry() :
	retry.emit()

func press_MainMenu() :
	mainMenu.emit()

func play_death() :
	animation.play("die")
