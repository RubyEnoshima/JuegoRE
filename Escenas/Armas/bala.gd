class_name Bala
extends Area2D

export var speed = 2000
var armaDisparada

func _ready():
	$duracion.start()

func _process(delta):
	position += Vector2(1, 0).rotated(rotation) * speed * delta

func _on_duracion_timeout():
	queue_free()

func _on_Bala_body_entered(body):
	if body is Enemigo:
		queue_free()
		body.calculaDano(armaDisparada.potencia,position)
