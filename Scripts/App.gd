extends Control


var gameRess : Resource = preload("res://Scenes/Game/Game.tscn")

@onready var loadingScreen : Control = $LoadingScreen
@onready var mainMenu : Control = $MainMenu
@onready var gameOver : Control = $GameOver

var game : Control 

func start_game() :
	
	loadingScreen.show()
	loadingScreen.start_loading()
	
	mainMenu.hide()
	gameOver.hide()
	
	game = gameRess.instantiate()
	
	game.player_died.connect(game_over)
	add_child(game)
	
	
	loadingScreen.hide()

func game_over() :
	game.queue_free()
	
	gameOver.show()
	gameOver.play_death()

func return_menu() :
	gameOver.hide()
	mainMenu.show()
