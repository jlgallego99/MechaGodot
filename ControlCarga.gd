extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var CargarParte1 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Por defecto estamos en la parte de arriba
	#Global.ObjetosAbajo.queue_free()
	pass

func _on_ControlCarga_body_exited(body):
	# Solo controlar que el que pasa es el jugador
	if body == Global.Player:
		if CargarParte1:
			# Si estamos en la parte uno, antes del ascensor, eliminamos todo lo de abajo
			CargarParte1 = true
			Global.ObjetosAbajo.queue_free()
		else:
			# Si hemos cogido el ascensor, eliminamos todo lo de arriba
			CargarParte1 = false
			Global.ObjetosPrincipal.queue_free()
			Global.Pasillos.queue_free()
			Global.AdornosPlantaBaja.queue_free()
			Global.AdornosPlanta1.queue_free()

