class_name ObjetoRecogible
extends Area2D

var aura = preload("res://aura.tres")
var focus = false

func _ready():
	input_pickable = true

func _process(delta):
	if focus and Input.is_action_just_pressed("coger"):
		interactuar()

func interactuar():
	queue_free()

func _on_Objeto_mouse_entered():
	$Sprite.material = aura
	focus = true

func _on_Objeto_mouse_exited():
	$Sprite.material = null
	focus = false
