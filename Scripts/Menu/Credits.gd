extends Control

signal back


func get_back() :
	hide()
	back.emit()
