extends CharacterBody2D

signal shoot(pos, ang)
signal subshoot(pos, ang)

@onready var ProjectileTimer := $ProjectileTimer
@onready var SubProjectileTimer := $SubProjectileTimer

var rng := RandomNumberGenerator.new()
var auto_fire : bool = false
var max_health = 100
var health = max_health
var speed = 200
var firerate = 1
var dmg = 1
var projectile_speed = 500
var projectiles = 100
var spread = 180
var bounces = 1

func _ready() -> void:
	ProjectileTimer.wait_time = firerate
	SubProjectileTimer.wait_time = firerate / 2.5

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())

	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("autofire"):
		auto_fire = !auto_fire
	
	#main wep
	if (Input.is_action_pressed("shoot") or auto_fire) and ProjectileTimer.is_stopped() and ProjectileTimer.wait_time >= 0.05:
		for i in projectiles:
			shoot.emit(position, rotation_degrees + rng.randi_range(-spread / 2, spread / 2))
			ProjectileTimer.start()

	#sub wep
	if (Input.is_action_pressed("subshoot") or auto_fire) and SubProjectileTimer.is_stopped() and SubProjectileTimer.wait_time >= 0.05:
		for i in projectiles:
			subshoot.emit(position, rotation_degrees + rng.randi_range(-spread / 2, spread / 2))
			SubProjectileTimer.start()
