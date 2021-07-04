class_name Enemigo
extends KinematicBody2D

var Sangre = preload("res://Escenas/Objetos/ObjetoRecogible.tscn")

export (int) var speed = 115
export (int) var gravity = 4000
export var vida = 4
export var defensa = 1

var derecha = true
var corriendo = false
var velocity = Vector2.ZERO

func calculaDano(dano,posicionDano):
	vida -= dano
	var emit = Sangre.instance()
	add_child(emit)
	emit.global_position = posicionDano

func get_input():
	velocity.x = 0
	#velocity.x += speed

func _physics_process(delta):
	if vida==0:
		queue_free() #ESTO HAY QUE CAMBIARLO POR ANIMACION DE MUERTE, PORQUE
		#PUEDEN RESUCITAR!!!!
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
