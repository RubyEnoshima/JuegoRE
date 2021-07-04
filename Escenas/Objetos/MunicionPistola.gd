class_name MunicionPistola
extends "res://Escenas/Objetos/ObjetoRecogible.gd"

export var cantidad = 7

func _on_Objeto_body_entered(body):
	if body is Personaje:
		Inventario.balasPistola += cantidad
	._on_Objeto_body_entered(body)
