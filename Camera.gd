extends Spatial

const SPEED = 2
const ROTMAX_ARRIBA = -90
const ROTMAX_ABAJO = 35
var roty_total = 0
var rotx_total = 0

func _ready():
	pass

func _process(delta):
	# Orbitar la cámara
	orbital(delta)
	
	# Iniciar animación si se pulsa la tecla ESPACIO
	if Input.is_action_pressed("Iniciar_Animacion"):
		$CameraX/Camera/AnimarCamara.play("Mover")

func orbital(delta):
	if Input.is_action_pressed("Camara_derecha"):
		roty_total += 2
		rotate_object_local(Vector3(0, 1, 0), SPEED * delta)
	elif Input.is_action_pressed("Camara_izquierda"):
		roty_total -= 2
		rotate_object_local(Vector3(0, 1, 0), -SPEED * delta)
	
	if Input.is_action_pressed("Camara_arriba") && rotx_total >= ROTMAX_ARRIBA:
		rotx_total -= 2
		$CameraX.rotate_object_local(Vector3(1, 0, 0), -SPEED * delta)
	elif Input.is_action_pressed("Camara_abajo") && rotx_total <= ROTMAX_ABAJO:
		rotx_total += 2
		$CameraX.rotate_object_local(Vector3(1, 0, 0), SPEED * delta)
