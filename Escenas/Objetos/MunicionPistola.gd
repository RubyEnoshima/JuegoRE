class_name MunicionPistola
extends "res://Escenas/Objetos/ObjetoRecogible.gd"

export var cantidad = 7

func interactuar():
	Inventario.balasPistola += cantidad
	.interactuar()
