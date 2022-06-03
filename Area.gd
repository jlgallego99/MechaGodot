extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var boton = get_node("AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_input_event(camera, event, position, normal, shape_idx):
	if Input.is_action_just_pressed("LMB"):
		boton.play("PulsarBoton")
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		Global.Ascensor.Mover()
