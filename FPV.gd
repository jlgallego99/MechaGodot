extends Spatial

const SPEED = 2
const ROTMAX_ARRIBA = 90
const ROTMAX_ABAJO = -90

onready var Yaw = get_parent()

# Sensibilidad del ratón (para que se mueva la cámara más rápido o lento)
export var SENSIBILIDAD = 300

func _ready():
	# Al iniciar el entorno, ocultar el ratón únicamente dentro del viewport
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	# Cerrar el entorno al pulsar la tecla ESCAPE
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
	var rot_pos = SPEED * delta
	var rot_neg = -SPEED * delta	
	
	# Mover la vista de la cámara con las flechas
	if Input.is_action_pressed("Camara_derecha"):
		Yaw.rotate_object_local(Vector3(0, 1, 0), rot_neg)
	elif Input.is_action_pressed("Camara_izquierda"):
		Yaw.rotate_object_local(Vector3(0, 1, 0), rot_pos)
	
	if Input.is_action_pressed("Camara_arriba") && (get_rotation_degrees()[0] + rot_pos) <= ROTMAX_ARRIBA:
		rotate_object_local(Vector3(1, 0, 0), rot_pos)
	elif Input.is_action_pressed("Camara_abajo") && (get_rotation_degrees()[0] + rot_neg) >= ROTMAX_ABAJO:
		rotate_object_local(Vector3(1, 0, 0), rot_neg)
		
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
	# La sensibilidad actúa como el delta en las teclas
	if event is InputEventMouseMotion:
		var rotx = event.relative.y / -SENSIBILIDAD
		var roty = event.relative.x / -SENSIBILIDAD
		var siguiente_rotx = get_rotation_degrees()[0] + rotx
		
		if siguiente_rotx >= ROTMAX_ABAJO && siguiente_rotx <= ROTMAX_ARRIBA:
			rotate_object_local(Vector3(1, 0, 0), rotx)
		#if get_rotation_degrees()[0] >= ROTMAX_ARRIBA && get_rotation_degrees()[0] <= ROTMAX_ABAJO:
		
			
		Yaw.rotate_object_local(Vector3(0, 1, 0), roty)
