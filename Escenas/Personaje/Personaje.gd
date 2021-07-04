class_name Personaje
extends KinematicBody2D

export (int) var speed = 115
export (int) var jump_speed = -1800
export (int) var gravity = 4000
export var canJump = true

var derecha = true
var corriendo = false
var mouse
var velocity = Vector2.ZERO

func _ready():
	if Inventario.pistola:
		$Arma.visible = true #No!!!!!!!!!!!!!!!!!
	else:
		$Arma.visible = false

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("mov_der"):
		velocity.x += speed
	if Input.is_action_pressed("mov_izq"):
		velocity.x -= speed
	if Input.is_action_pressed("correr") and !corriendo:
		corriendo = true
		speed *= 2.7
	elif Input.is_action_just_released("correr") and corriendo:
		corriendo = false
		speed /= 2.7
	if Inventario.pistola: #Esto esta mal!!!!!!!!!!!!
		if Input.is_action_just_pressed("disparo"):
			$Arma.disparar()
		elif Input.is_action_just_pressed("recargar"):
			$Arma.recargar()
		

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("ui_up") and canJump:
		if is_on_floor():
			velocity.y = jump_speed
	mouse = get_local_mouse_position()