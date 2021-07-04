class_name ObjetoRecogible
extends Area2D

func _on_Objeto_body_entered(body):
	if body is Personaje:
		queue_free()
