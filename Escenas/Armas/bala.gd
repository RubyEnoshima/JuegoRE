class_name Bala
extends Area2D

export var speed = 1500
var armaDisparada
var Sangre = preload("res://Escenas/Particulas/Sangre.tscn")
func _ready():
	$duracion.start()

func _process(delta):
	position += Vector2(1, 0).rotated(rotation) * speed * delta

func _on_duracion_timeout():
	queue_free()

func _on_Bala_body_entered(body):
	if body is Enemigo:
		var emit = Sangre.instance()
		get_parent().add_child(emit)
		emit.global_position = position
		randomize()
		if global_position.x < body.global_position.x:
			emit.process_material.initial_velocity=rand_range(-30,-45)
		else:
			emit.process_material.initial_velocity=rand_range(30,45)
		queue_free()
		body.calculaDano(armaDisparada.potencia,armaDisparada)
