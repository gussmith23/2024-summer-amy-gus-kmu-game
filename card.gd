extends Node2D

signal card_picked_up(card)
signal card_released(card)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var offset = null

func _process(_delta):
	if Input.is_action_just_pressed("click"): offset = get_global_mouse_position()
	elif Input.is_action_pressed("click"):
		global_position = get_global_mouse_position()
	elif Input.is_action_just_released("click"): offset = null
	
func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("click"):
		card_picked_up.emit(self)
	elif event.is_action_released("click"):
		card_released.emit(self)
