extends Spatial

func _ready():
	pass # Replace with function body.

func _process(delta):
	# Iniciar animación básica al presionar la tecla ESPACIO
	if Input.is_action_pressed("Iniciar_Animacion"):
		$Ascensor/AnimarAscensor.play("Subir")