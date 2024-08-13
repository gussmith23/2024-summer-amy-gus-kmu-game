extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var active_slot = null

func _on_card_slot_mouse_entered(slot):
	active_slot = slot


func _on_card_slot_mouse_exited(slot):
	if active_slot == slot:
		active_slot = null

var held_card = null

func _on_card_picked_up(card):
	held_card = card



func _on_card_released(card:Variant):
	if active_slot != null:
		card.global_position = active_slot.global_position
		card.rotation = active_slot.rotation

	if held_card == card:
		held_card = null

