class_name ObjetoRecogible
extends Area2D

var focus = false
var aura = preload("res://aura.tres")

func _process(delta):
	var mouse = get_global_mouse_position()
	var width = $Sprite.texture.get_width()*$Sprite.scale.x / 2
	var height = $Sprite.texture.get_height()*$Sprite.scale.y/2
	var enFocus = mouse.x >= position.x - width and mouse.x <= position.x + width and mouse.y >= position.y - height and mouse.y <= position.y + height
	if !focus and enFocus:
		$Sprite.material = aura
	elif focus and !enFocus:
		focus = false
		$Sprite.material = null

func _on_Objeto_body_entered(body):
	if body is Personaje:
		queue_free()
