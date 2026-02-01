extends Control

signal start

@onready var firstLayer :  VBoxContainer = $FirstLayer

func hide_first_layer() :
	firstLayer.hide()

func show_first_layer() :
	firstLayer.show()

func start_pressed() -> void:
	start.emit()


func setting_pressed() -> void:
	hide_first_layer()


func credit_pressed() -> void:
	hide_first_layer()


func quit_pressed() -> void:
	pass # Replace with function body.
