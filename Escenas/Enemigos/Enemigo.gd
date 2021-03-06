class_name Enemigo
extends KinematicBody2D

var a = [
		 preload("res://Assets/Sonidos/Zombi/zombie_pain0.wav"),
		 preload("res://Assets/Sonidos/Zombi/zombie_pain1.wav")
		]
var tono
export (int) var speed = 40
export (int) var gravity = 4000
export var vida = 7 
#la vida se cuantificarÃ¡ en una unidad de balas de pistola (1)
#en este caso, derrotar a un zombi implica dispararle una ronda entera de pistola
export var defensa = 1

export var derecha = true
var corriendo = false
var velocity = Vector2.ZERO
var detectado = false
var atacando = false
var dir

func _ready():
	if !derecha:
		scale *= -1

func calculaDano(dano,arma):
	vida -= dano
	randomize()
	$pain.stream = a[randi()%2]
	$pain.play()
	if !detectado:
		detectado = true
		dir = arma
		if (arma.global_position.x > global_position.x and !derecha) or (arma.global_position.x <= global_position.x and derecha):
			scale.x *= -1
			derecha = !derecha

func _physics_process(delta):
	if vida==0:
		queue_free() #ESTO HAY QUE CAMBIARLO POR ANIMACION DE MUERTE, PORQUE
		#PUEDEN RESUCITAR!!!!
	velocity.x = 0
	if detectado and !atacando:
		if dir.global_position.x > global_position.x:
			velocity.x += speed
		else:
			velocity.x -= speed
	elif atacando:
		ataca()
	#HAY QUE HACER QUE MERODEE UN POCO TAMBIEN
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func ataca():
	print("ataco")
	pass

func _on_detecta_body_entered(body):
	if body is Personaje:
		dir = body
		detectado = true


func _on_danger_body_entered(body):
	if body is Personaje:
		atacando = true


#func _on_detecta_body_exited(body):
#	if body is Personaje:
#		detectado = false

func _on_danger_body_exited(body):
	if body is Personaje:
		atacando = false


func _on_detras_body_entered(body):
	if body is Personaje:
		scale.x *= -1
		derecha = !derecha
		detectado = true
		dir = body
