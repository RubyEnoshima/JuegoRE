class_name ObjetoRecogible
extends Area2D

var aura = preload("res://aura.tres")
var interactuado = false
var focus = false
var jugadorCerca = false

func _ready():
	input_pickable = true
	#Warning porque me conozco
	if $Jugador/CollisionShape2D.shape == null:
		print("El objeto ",name," no tiene un area de Jugador delimitada!!")
	if $TextoInteractuado.text == "":
		print("El objeto ",name," no tiene texto!")

func _process(delta):
	if focus and Input.is_action_just_pressed("coger") and jugadorCerca:
		interactuar()
	if $TextoInteractuado.visible:
		$TextoInteractuado.rect_position.y -= 0.3

func interactuar():
	interactuado = true
	$Sprite.queue_free()
	$TextoInteractuado.visible = true
	$Timer.start()

func _on_Objeto_mouse_entered():
	if !interactuado and jugadorCerca:
		$Sprite.material = aura
		focus = true
		

func _on_Objeto_mouse_exited():
	if !interactuado and jugadorCerca:
		$Sprite.material = null
		focus = false

func _on_Timer_timeout():
	queue_free()

func _on_Jugador_body_entered(body):
	if body is Personaje and !interactuado:
		jugadorCerca = true

func _on_Jugador_body_exited(body):
	if body is Personaje and !interactuado:
		$Sprite.material = null
		jugadorCerca = false
