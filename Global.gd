extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var Raiz
var RaizEstacion
var Player
var Ascensor
var AdornosPlanta1
var AdornosPlantaBaja
var Pasillos
var ObjetosPrincipal
var ObjetosAbajo

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Elimina todos los hijos de un nodo para descargarlo
func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
		
	node.call_deferred("free")
