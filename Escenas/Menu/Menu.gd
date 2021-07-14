class_name Menu
extends Node2D

var focus
var leyendo = false
var aura = preload("res://Assets/Shaders/objetoMenu.tres")

func _ready():
	var i = 0
	for objeto in Inventario.objetosMenu:
		var nodo = $Objetos.get_child(i)
		nodo.icon = load("res://Assets/Sprites/Objetos/"+objeto+".png")
		nodo.connect("mouse_entered",self,"mouseEntra",[nodo])
		nodo.connect("mouse_exited",self,"mouseSale",[nodo])
		nodo.get_popup().add_item("Examinar")
		if objeto.begins_with("balas"):
			$Labels.get_child(i).text = str(Inventario.balas[objeto])
		elif objeto == "Pistola" or objeto == "Escopeta":
			if Inventario.equipado != objeto:
				nodo.get_popup().add_item("Equipar")
			else:
				nodo.get_popup().add_item("Desequipar")
			$Labels.get_child(i).text = str(Inventario.municionActual[objeto])
		if objeto.begins_with("clave"): #No sé...
			nodo.get_popup().add_item("Combinar")
		nodo.get_popup().connect("id_pressed",self,"acciones",[nodo,objeto])
		i+=1

func _process(delta):
	if leyendo:
		if $Examinar.percent_visible < 1:
			$Examinar.percent_visible += 0.005
		else:
			leyendo = false

func equipar(objeto):
	if Inventario.equipado!=objeto:
		Inventario.equipado = objeto
	else:
		Inventario.equipado = ""

func examinar(objeto):
	$Examinar.text = ExaminarDialogos.dialogos[objeto]
	$Examinar.percent_visible = 0
	leyendo = true

func combinar(objeto):
	pass

func acciones(id,sender,objeto):
	var accion = sender.get_popup().get_item_text(id)
	if accion == "Examinar": examinar(objeto)
	elif accion == "Combinar": combinar(objeto)
	elif accion == "Equipar" or accion == "Desequipar": equipar(objeto)

func mouseEntra(objeto):
	objeto.material = aura
	focus = objeto
	
func mouseSale(objeto):
	objeto.material = null
	focus = null
