extends KinematicBody

const SPEED = 2
const ROTMAX_ARRIBA = 90
const ROTMAX_ABAJO = -90
const ACELERACION = 4
const DESACELERACION = 16
const GRAVEDAD = -50
const MAXIMA_VELOCIDAD = 10

onready var camera = get_node("./Vista_Avatar")

# Sensibilidad del ratón (para que se mueva la cámara más rápido o lento)
export var SENSIBILIDAD = 300

var velocidad = Vector3(0, 0, 0)
var direccion = Vector3(0, 0, 0)

# Rotación en el eje x que lleva la cámara, para limitar el Pitch
var rotx = 0

func _ready():
	Global.Player = self
	# Al iniciar el entorno, ocultar el ratón únicamente dentro del viewport
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Cerrar el entorno al pulsar la tecla ESCAPE
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
	# Mostrar/ocultar ratón
	if Input.is_action_just_pressed("mostrar_ui"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
		
	direccion = Vector3()
	var cam_xform = camera.get_global_transform()
	var input_vec = Vector2(0, 0)
	
	# Controlar cámara sólo si está activa
	if camera.current && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		# Mover la vista de la cámara con las flechas
		if Input.is_action_pressed("Camara_derecha"):
			rotate_object_local(Vector3(0, 1, 0), -SPEED * delta)
		elif Input.is_action_pressed("Camara_izquierda"):
			rotate_object_local(Vector3(0, 1, 0), SPEED * delta)
		
		if Input.is_action_pressed("Camara_arriba") && rotx <= ROTMAX_ARRIBA:
			rotx += rad2deg(SPEED * delta)
			camera.rotate_object_local(Vector3(1, 0, 0), SPEED * delta)
		elif Input.is_action_pressed("Camara_abajo") && rotx >= ROTMAX_ABAJO:
			rotx += rad2deg(-SPEED * delta)
			camera.rotate_object_local(Vector3(1, 0, 0), -SPEED * delta)
			
		# Trasladar el personaje con WASD
		if Input.is_action_pressed("fpv_izquierda"):
			#Yaw.translate_object_local(Vector3(0, 0, -0.8))
			#direccion -= camera.global_transform.basis.x
			input_vec.x -= 1
		elif Input.is_action_pressed("fpv_derecha"):
			#Yaw.translate_object_local(Vector3(0, 0, 0.8))
			#direccion += camera.global_transform.basis.x
			input_vec.x += 1
		elif Input.is_action_pressed("fpv_detras"):
			#Yaw.translate_object_local(Vector3(-0.8, 0, 0))
			#direccion += camera.global_transform.basis.z
			input_vec.y -= 1
		elif Input.is_action_pressed("fpv_delante"):
			#Yaw.translate_object_local(Vector3(0.8, 0, 0))
			#direccion -= camera.global_transform.basis.z
			input_vec.y += 1
		
		input_vec = input_vec.normalized()
		direccion += -cam_xform.basis.z * input_vec.y
		direccion += cam_xform.basis.x * input_vec.x
		direccion.y = 0
		
		velocidad.y += delta * GRAVEDAD
		
		var hvel = velocidad
		hvel.y = 0
		var target = direccion
		target *= MAXIMA_VELOCIDAD
		var accel
		if direccion.dot(hvel) > 0:
			accel = ACELERACION
		else:
			accel = DESACELERACION
			
		hvel = hvel.linear_interpolate(target, accel * delta)
		velocidad.x = hvel.x
		velocidad.z = hvel.z
		velocidad = move_and_slide(velocidad, Vector3(0, 1, 0), 0.05, 4, deg2rad(40))
		
func _input(event):
	# Mover la cámara con el ratón (sólo si es la activa)
	if event is InputEventMouseMotion && camera.current && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:		
		if (event.relative.y <= 0 && rotx <= ROTMAX_ARRIBA) || (event.relative.y > 0 && rotx >= ROTMAX_ABAJO):
			rotx += rad2deg(event.relative.y / -SENSIBILIDAD)
			camera.rotate_object_local(Vector3(1, 0, 0), event.relative.y / -SENSIBILIDAD)		
			
		rotate_object_local(Vector3(0, 1, 0), event.relative.x / -SENSIBILIDAD)





func _on_Control_Camara_camara2():
	camera.set_current(true)
	
