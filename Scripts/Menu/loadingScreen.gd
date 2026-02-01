extends Control

@onready var animation : AnimationPlayer = $AnimationPlayer

func start_loading() :
	animation.play("SpiningHead")
