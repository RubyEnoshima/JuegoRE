class_name Pistola
extends "res://Escenas/Objetos/ObjetoRecogible.gd"

signal equipar

func interactuar():
	Inventario.anadir("Pistola",0)
	emit_signal("equipar","Pistola")
	.interactuar()
