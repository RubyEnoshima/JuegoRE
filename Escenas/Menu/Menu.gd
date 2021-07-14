class_name Menu
extends Node2D

var focus
var leyendo = false
var aura = preload("res://Assets/Shaders/objetoMenu.tres")

signal equipar
signal desequipar

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

func equipar(objeto,sender,id):
	if Inventario.equipado!=objeto:
		Inventario.equipado = objeto
		emit_signal("equipar",objeto)
		for child in $Objetos.get_children():
			var popup = child.get_popup()
			for i in range(popup.get_item_count()):
				if popup.get_item_text(i)=="Desequipar":
					 popup.set_item_text(i,"Equipar")
		sender.get_popup().set_item_text(id,"Desequipar")
	else:
		Inventario.equipado = ""
		emit_signal("desequipar")
		for child in $Objetos.get_children():
			var popup = child.get_popup()
			for i in range(popup.get_item_count()):
				if popup.get_item_text(i)=="Equipar":
					 popup.set_item_text(i,"Desequipar")
		sender.get_popup().set_item_text(id,"Equipar")

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
	elif accion == "Equipar" or accion == "Desequipar": equipar(objeto,sender,id)

func mouseEntra(objeto):
	objeto.material = aura
	focus = objeto
	
func mouseSale(objeto):
	objeto.material = null
	focus = null
