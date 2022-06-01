extends Area

var CargarMitad = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Por defecto estamos en la parte de arriba
	Global.ObjetosAbajo.queue_free()

func _on_ControlCarga_body_exited(body):
	# Solo controlar que el que pasa es el jugador
	if body == Global.Player:
		if CargarMitad:
			# Si estamos en la parte uno, antes del ascensor
			# Eliminamos todo lo de abajo y cargamos todo lo de arriba
			CargarMitad = false
			Global.ObjetosAbajo.queue_free()
			CargarPrimeraMitad()
		else:
			# Si hemos cogido el ascensor hacia abajo
			# Eliminamos todo lo de arriba y cargamos todo lo de abajo
			CargarMitad = true
			Global.ObjetosPrincipal.queue_free()
			Global.Pasillos.queue_free()
			Global.AdornosPlantaBaja.queue_free()
			Global.AdornosPlanta1.queue_free()
			CargarSegundaMitad()

# Cargar los objetos de la mitad superior
func CargarPrimeraMitad():
	var nodo_ObjetosPrincipal = preload("res://ObjetosPrincipal.tscn")
	var instancia1 = nodo_ObjetosPrincipal.instance()
	Global.RaizEstacion.add_child(instancia1)
	
	var nodo_Pasillos = preload("res://Pasillos.tscn")
	var instancia2 = nodo_Pasillos.instance()
	Global.RaizEstacion.add_child(instancia2)
	
	var nodo_AdornosPlantaBaja = preload("res://AdornosPlantaBaja.tscn")
	var instancia3 = nodo_AdornosPlantaBaja.instance()
	Global.Raiz.add_child(instancia3)
	
	var nodo_AdornosPlanta1 = preload("res://AdornosPlanta1.tscn")
	var instancia4 = nodo_AdornosPlanta1.instance()
	Global.Raiz.add_child(instancia4)

# Cargar los objetos de la mitad inferior
func CargarSegundaMitad():
	var nodo_ObjetosAbajo = preload("res://ObjetosAbajo.tscn")
	var instancia = nodo_ObjetosAbajo.instance()
	Global.RaizEstacion.add_child(instancia)
