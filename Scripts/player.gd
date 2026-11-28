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

var dmg = 1
var firerate = 1
var knockback = 300
var projectile_speed = 500
var projectiles = 1
var spread = 0
var bounces = 0
var pierces = 0
var ricochets = 0
var warps = 0

var sub_dmg = 0.2
var sub_firerate = 2.5
var sub_knockback = 60
var sub_projectile_speed = 500
var sub_projectiles = 1
var sub_spread = 0
var sub_bounces = 0
var sub_pierces = 0
var sub_ricochets = 0
var sub_warps = 0

func _ready() -> void:
	ProjectileTimer.wait_time = 1.0 / firerate
	SubProjectileTimer.wait_time = 1.0 / sub_firerate

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())

	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("autofire"):
		auto_fire = !auto_fire
	
	#main wep
	if (Input.is_action_pressed("shoot") or auto_fire) and ProjectileTimer.is_stopped():
		for i in projectiles:
			shoot.emit(position, rotation_degrees + rng.randi_range(-spread / 2, spread / 2))
			ProjectileTimer.start()

	#sub wep
	if (Input.is_action_pressed("subshoot") or auto_fire) and SubProjectileTimer.is_stopped():
		for i in sub_projectiles:
			subshoot.emit(position, rotation_degrees + rng.randi_range(-sub_spread / 2, sub_spread / 2))
			SubProjectileTimer.start()
