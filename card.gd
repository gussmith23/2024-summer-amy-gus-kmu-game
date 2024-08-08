extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var offset = null

func _process(delta):
	if Input.is_action_just_pressed("click"): offset = get_global_mouse_position()
	elif Input.is_action_pressed("click"):
		global_position = get_global_mouse_position() - offset
	elif Input.is_action_just_released("click"): offset = null
	
func _input(event):
	pass

