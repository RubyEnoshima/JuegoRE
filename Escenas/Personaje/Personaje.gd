class_name Personaje
extends KinematicBody2D

var Menu = preload("res://Escenas/Menu/Menu.tscn")
var enMenu = false

export (int) var speed = 115
export (int) var gravity = 4000
export var vida = 100
export var defensa = 1

var derecha = true
var pitch = false
var corriendo = false
var velocity = Vector2.ZERO

func _ready():
	if Inventario.pistola:
		$Arma.visible = true #No!!!!!!!!!!!!!!!!!
	else:
		$Arma.visible = false

func pisadas():
	if corriendo and !pitch:
		$pisadas.pitch_scale *= 1.25
		pitch = true
	elif !corriendo:
		$pisadas.pitch_scale = 1
		pitch = false
	if !$pisadas.playing: 
		$pisadas.play()

func get_input():
	if !enMenu:
		velocity.x = 0
		if Input.is_action_pressed("mov_der"):
			pisadas()
			velocity.x += speed
			#$Arma.disabled = true
		
		if Input.is_action_pressed("mov_izq"):
			pisadas()
			velocity.x -= speed
			#$Arma.disabled = true
	
		if Inventario.pistola: #Esto esta mal!!!!!!!!!!!!
			if Input.is_action_just_pressed("disparo"):
				$Arma.disparar()
			elif Input.is_action_just_pressed("recargar"):
				$Arma.recargar()
		
		if !velocity.x or Input.is_action_just_released("mov_der") or Input.is_action_just_released("mov_izq"):
			$pisadas.stop()
		
		if Input.is_action_pressed("correr") and !corriendo:
			corriendo = true
			speed *= 2.7
		elif Input.is_action_just_released("correr") and corriendo:
			corriendo = false
			speed /= 2.7
		
		var mouse = get_global_mouse_position()
		if mouse.x >= position.x:
			if !derecha:
				derecha = true
			$Sprite.flip_h = !$Sprite.flip_h
		elif mouse.x < position.x:
			if derecha:
				derecha = false
			$Sprite.flip_h = !$Sprite.flip_h
		
	
	if Input.is_action_just_pressed("menu"):
		var m = Menu.instance()
		var children = get_parent().get_children()
		for child in children:
			child.visible = false
		get_parent().add_child(m)
		enMenu = true
		#get_tree().change_scene("res://Escenas/Menu/Menu.tscn")

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
