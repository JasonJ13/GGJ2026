extends Control


var game : Resource = preload("res://Scenes/Game/Game.tscn")

@onready var loadingScreen : Control = $LoadingScreen
@onready var mainMenu : Control = $MainMenu

func start_game() :
	
	loadingScreen.show()
	loadingScreen.start_loading()
	
	mainMenu.hide()
	add_child(game.instantiate())
	
	loadingScreen.hide()
