class_name Menu
extends Node2D

func _ready():
	var i = 0
	for objeto in Inventario.objetosMenu:
		if objeto.begins_with("balas"):
			$Objetos/Labels.get_child(i).text = str(Inventario.balas[objeto])
		elif objeto == "Pistola":
			$Objetos/Labels.get_child(i).text = str(Inventario.municionActual[objeto])
		$Objetos.get_child(i).texture = load("res://Assets/Sprites/Objetos/"+objeto+".png")
		i+=1
