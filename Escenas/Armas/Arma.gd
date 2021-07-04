extends Node2D

var Bala = preload("res://Escenas/Armas/bala.tscn")

export var fireRate = 0.7
export var municionMax = 7
export var municionActual = 0
export var retroceso = 105

var sePuedeDisparar = true
var recargando = false
var giro = false

func _ready():
	$fireRate.wait_time = fireRate

func _process(delta):
	var angulo = rad2deg(get_global_mouse_position().angle_to_point(global_position))
	if angulo <= 60 and angulo >= -60:
		if giro:
			giro = false
			$Sprite.flip_v = !$Sprite.flip_v
		look_at(get_global_mouse_position())
	elif -angulo >= 120 and -angulo <=180 or -angulo >= -180 and -angulo <= -120:
		if !giro:
			giro = true
			$Sprite.flip_v = !$Sprite.flip_v
		look_at(get_global_mouse_position())

func disparar():
	if sePuedeDisparar and municionActual>0 and !recargando:
		var b=Bala.instance()
		get_parent().get_parent().add_child(b)
		b.global_position = $Sprite.global_position
		b.rotate(rotation)
		$sonido.play()
		$fireRate.start()
		if get_parent().derecha:
			get_parent().velocity.x -= retroceso
		else:
			get_parent().velocity.x += retroceso
			
		sePuedeDisparar = false
		municionActual-=1
	elif !municionActual:
		if Inventario.balasPistola>0:
			recargar()
		else:
			$no_ammo.play()
		#$fireRate.start()
		#sePuedeDisparar = false
	print(municionActual)

func recargar():
	if !recargando:
		if municionActual < municionMax and Inventario.balasPistola>0:
			recargando = true
			var balasNecesarias = municionMax - municionActual
			if Inventario.balasPistola >= balasNecesarias:
				municionActual += balasNecesarias
				Inventario.balasPistola -= balasNecesarias
			else:
				municionActual += Inventario.balasPistola
				Inventario.balasPistola = 0
			$reload.play()
		elif !municionActual and !Inventario.balasPistola:
			$no_ammo.play()

func _on_fireRate_timeout():
	sePuedeDisparar = true


func _on_reload_finished():
	recargando = false
