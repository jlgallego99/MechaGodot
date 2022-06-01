extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim = get_node("AnimationPlayer")
var abajo = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.Ascensor = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Mover():
	if !abajo:
		abajo = true
		anim.play("MoverAscensor")
	else:
		abajo = false
		anim.play_backwards("MoverAscensor")
