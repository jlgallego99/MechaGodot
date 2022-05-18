extends Control

signal camara1
signal camara2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Cambiar_Camara"):
		if get_viewport().get_camera().name == "Camara_Aux":
			emit_signal("camara2")
		else:
			emit_signal("camara1")
