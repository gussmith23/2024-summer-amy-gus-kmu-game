extends Node2D

signal mouse_entered(s)
signal mouse_exited(s)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_mouse_entered():
	mouse_entered.emit(self) 


func _on_area_2d_mouse_exited():
	mouse_exited.emit(self)
