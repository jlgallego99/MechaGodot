extends Camera

const SPEED = 2
const ROTMAX_ARRIBA = 90
const ROTMAX_ABAJO = -90

onready var Yaw = get_parent()

# Sensibilidad del ratón (para que se mueva la cámara más rápido o lento)
export var SENSIBILIDAD = 300

# Rotación en el eje x que lleva la cámara, para limitar el Pitch
var rotx = 0

func _ready():
	# Al iniciar el entorno, ocultar el ratón únicamente dentro del viewport
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	# Cerrar el entorno al pulsar la tecla ESCAPE
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
	# Controlar cámara sólo si está activa
	if current:
		# Mover la vista de la cámara con las flechas
		if Input.is_action_pressed("Camara_derecha"):
			rotx += rad2deg(-SPEED * delta)
			Yaw.rotate_object_local(Vector3(0, 1, 0), -SPEED * delta)
		elif Input.is_action_pressed("Camara_izquierda"):
			rotx += rad2deg(SPEED * delta)
			Yaw.rotate_object_local(Vector3(0, 1, 0), SPEED * delta)
		
		if Input.is_action_pressed("Camara_arriba") && rotx <= ROTMAX_ARRIBA:
			rotx += rad2deg(SPEED * delta)
			rotate_object_local(Vector3(1, 0, 0), SPEED * delta)
		elif Input.is_action_pressed("Camara_abajo") && rotx >= ROTMAX_ABAJO:
			rotx += rad2deg(-SPEED * delta)
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
	# Mover la cámara con el ratón (sólo si es la activa)
	if event is InputEventMouseMotion && current:		
		if (event.relative.y <= 0 && rotx <= ROTMAX_ARRIBA) || (event.relative.y > 0 && rotx >= ROTMAX_ABAJO):
			rotx += rad2deg(event.relative.y / -SENSIBILIDAD)
			rotate_object_local(Vector3(1, 0, 0), event.relative.y / -SENSIBILIDAD)		
			
		Yaw.rotate_object_local(Vector3(0, 1, 0), event.relative.x / -SENSIBILIDAD)


func _on_Control_Camara_camara2():
	# Poner esta cámara como la activa
	set_current(true)
