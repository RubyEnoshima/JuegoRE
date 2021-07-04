class_name Bala
extends Area2D

export var speed = 2000

func _ready():
	$duracion.start()

func _process(delta):
	position += Vector2(1, 0).rotated(rotation) * speed * delta

func _on_duracion_timeout():
	queue_free()

func _on_Bala_body_entered(body):
	if body.name != "Personaje":
		queue_free()
