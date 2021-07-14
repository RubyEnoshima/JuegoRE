extends Node2D

export var balas = {"balasPistola":0,
					"balasEscopeta":0,
					"balasRifle":0}
					
export var municionActual = {"Pistola":7,
					"Escopeta":4,
					"Rifle":20}

export var equipado = ""

var objetosMenu = []
var maxObjetos = 6

var baul = []
var maxBaul = 50

func _ready():
	OS.center_window()

func anadir(objeto,cantidad):
	if objetosMenu.size() < maxObjetos:
		if objeto.begins_with("balas"):
			balas[objeto] += cantidad
			if !objetosMenu.has(objeto):
				objetosMenu.append(objeto)
		else:
			objetosMenu.append(objeto)
			if objeto == "Pistola":
				equipado = "Pistola"
	
func meterBaul(objeto,cantidad):
	pass
