extends Spatial

const SPEED = 2
const ROTMAX_ARRIBA = -90
const ROTMAX_ABAJO = 35
var roty_total = 0
var rotx_total = 0

onready var Yaw = get_parent()

# Sensibilidad del ratón (para que se mueva la cámara más rápido o lento)
const SENSIBILIDAD = 300

func _ready():
	# Al iniciar el entorno, ocultar el ratón únicamente dentro del viewport
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	# Cerrar el entorno al pulsar la tecla ESCAPE
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
	# Mover la vista de la cámara con las flechas
	if Input.is_action_pressed("Camara_derecha"):
		roty_total += 2
		Yaw.rotate_object_local(Vector3(0, 1, 0), -SPEED * delta)
	elif Input.is_action_pressed("Camara_izquierda"):
		roty_total -= 2
		Yaw.rotate_object_local(Vector3(0, 1, 0), SPEED * delta)
	
	if Input.is_action_pressed("Camara_arriba") && rotx_total >= ROTMAX_ARRIBA:
		rotx_total -= 2
		rotate_object_local(Vector3(1, 0, 0), SPEED * delta)
	elif Input.is_action_pressed("Camara_abajo") && rotx_total <= ROTMAX_ABAJO:
		rotx_total += 2
		rotate_object_local(Vector3(1, 0, 0), -SPEED * delta)
		
	# Trasladar la cámara con WASD
	if Input.is_action_pressed("fpv_izquierda"):
		Yaw.translate_object_local(Vector3(0, 0, -0.5))
	elif Input.is_action_pressed("fpv_derecha"):
		Yaw.translate_object_local(Vector3(0, 0, 0.5))
	elif Input.is_action_pressed("fpv_detras"):
		Yaw.translate_object_local(Vector3(-0.5, 0, 0))
	elif Input.is_action_pressed("fpv_delante"):
		Yaw.translate_object_local(Vector3(0.5, 0, 0))
		
		
func _input(event):
	# Mover la cámara con el ratón
	if event is InputEventMouseMotion:
		# La sensibilidad actúa como el delta en las teclas
		Yaw.rotate_object_local(Vector3(0, 1, 0), event.relative.x / -SENSIBILIDAD)
		rotate_object_local(Vector3(1, 0, 0), event.relative.y / -SENSIBILIDAD)
