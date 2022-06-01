extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim = get_node("AnimationPlayer")
var abajo = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Ascensor"):
		if !abajo:
			abajo = true
			anim.play("MoverAscensor")
		else:
			abajo = false
			anim.play_backwards("MoverAscensor")
