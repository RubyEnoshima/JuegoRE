extends Node2D

var Bala = preload("res://Escenas/Armas/bala.tscn")

export var nombreArma = "Pistola"

export var fireRate = 0.7
export var municionMax = 7
export var retroceso = 105
export var potencia = 1
onready var municionActual = Inventario.municionActual[nombreArma]

export var anguloMaxDer = 60
onready var anguloMaxIzq = 90*2 - anguloMaxDer 

var sePuedeDisparar = true
var recargando = false
var giro = false
var disabled = false

func _ready():
	$fireRate.wait_time = fireRate

func mirarRaton():
	var angulo = rad2deg(get_global_mouse_position().angle_to_point(global_position))
	if nombreArma=="Escopeta": print(angulo)
	if angulo <= anguloMaxDer and angulo >= -anguloMaxDer:
		if giro:
			giro = false
			$Sprite.flip_v = !$Sprite.flip_v
		look_at(get_global_mouse_position())
	elif !(angulo < -anguloMaxDer and angulo > -anguloMaxIzq) and !(angulo < anguloMaxIzq and angulo > anguloMaxDer):
		if !giro:
			giro = true
			$Sprite.flip_v = !$Sprite.flip_v
		look_at(get_global_mouse_position())

func _process(delta):
	#if !disabled:
		mirarRaton()
	#else:
	#	if get_parent().derecha:
	#		rotation_degrees = 60
	#		$Sprite.flip_v = false
	#	else:
	#		rotation_degrees = 120
	#		$Sprite.flip_v = true

func disparar():
	#if !get_parent().velocity.x:
	#	if disabled:
	#		disabled = false
	#		mirarRaton()
		if sePuedeDisparar and municionActual>0 and !recargando:
			var b=Bala.instance()
			get_parent().get_parent().add_child(b)
			b.global_position = $Sprite.global_position
			b.rotate(rotation)
			b.armaDisparada = self
			$sonido.play()
			$fireRate.start()
			if get_parent().derecha:
				get_parent().velocity.x -= retroceso
			else:
				get_parent().velocity.x += retroceso
			sePuedeDisparar = false
			municionActual-=1
			Inventario.municionActual[nombreArma] -= 1
		elif !municionActual:
			if Inventario.balas["balas"+nombreArma]>0:
				recargar()
			else:
				$no_ammo.play()
			#$fireRate.start()
			#sePuedeDisparar = false

func recargar():
	if !recargando:
		var balasInv = Inventario.balas["balas"+nombreArma]
		if municionActual < municionMax and balasInv>0:
			recargando = true
			var balasNecesarias = municionMax - municionActual
			if balasInv >= balasNecesarias:
				municionActual += balasNecesarias
				balasInv -= balasNecesarias
			else:
				municionActual += balasInv
				balasInv = 0
			$reload.play()
			Inventario.municionActual[nombreArma] = municionActual
			Inventario.balas["balas"+nombreArma] = balasInv
			if balasInv == 0:
				Inventario.objetosMenu.erase("balas"+nombreArma)
				
		elif !municionActual and !balasInv:
			$no_ammo.play()

func _on_fireRate_timeout():
	sePuedeDisparar = true


func _on_reload_finished():
	recargando = false
