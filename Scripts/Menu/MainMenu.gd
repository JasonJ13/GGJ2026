extends Control

signal start

@onready var firstLayer :  VBoxContainer = $FirstLayer
@onready var option : Control = $Option
@onready var credit : Control = $Credits


func hide_first_layer() :
	firstLayer.hide()

func show_first_layer() :
	firstLayer.show()

func start_pressed() -> void:
	start.emit()


func setting_pressed() -> void:
	hide_first_layer()
	option.show()


func credit_pressed() -> void:
	hide_first_layer()
	credit.show()


func quit_pressed() -> void:
	get_tree().quit()
