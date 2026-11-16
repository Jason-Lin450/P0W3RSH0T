extends CharacterBody2D

signal shoot(pos, ang)
signal subshoot(pos, ang)

@onready var ProjectileTimer := $ProjectileTimer
@onready var SubProjectileTimer := $SubProjectileTimer

var AutoFire : bool = false
var max_health = 100
var health = max_health
var firerate = 20
var speed = 200

func _ready() -> void:
	ProjectileTimer.wait_time = firerate * 1.0 / 50
	SubProjectileTimer.wait_time = firerate * 1.0 / 20
	ProjectileTimer.start()
	SubProjectileTimer.start()

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())

	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("autofire"):
		AutoFire = !AutoFire
	
	#main wep
	if (Input.is_action_pressed("shoot") or AutoFire) and ProjectileTimer.is_stopped() and ProjectileTimer.wait_time >= 0.05:
		shoot.emit(position, rotation_degrees)
		ProjectileTimer.start()

	#sub wep
	if (Input.is_action_pressed("subshoot") or AutoFire) and SubProjectileTimer.is_stopped() and SubProjectileTimer.wait_time >= 0.05:
		subshoot.emit(position, rotation_degrees)
		SubProjectileTimer.start()
