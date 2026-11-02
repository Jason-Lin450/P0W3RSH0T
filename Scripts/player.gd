extends CharacterBody2D

signal shoot(pos, ang)
signal subshoot(pos, ang)

@onready var ProjectileTimer := $ProjectileTimer
@onready var SubProjectileTimer := $SubProjectileTimer

var ProjectileCD : bool = true
var SubProjectileCD : bool = true
var AutoFire : bool = false
var speed = 300.0

func _ready() -> void:
	ProjectileTimer.wait_time = 0.5
	SubProjectileTimer.wait_time = 0.2
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
	if (Input.is_action_pressed("shoot") or AutoFire) and ProjectileCD and ProjectileTimer.wait_time >= 0.05:
		shoot.emit(position, rotation_degrees)
		ProjectileCD = false
		ProjectileTimer.start()

	#sub wep
	if (Input.is_action_pressed("subshoot") or AutoFire) and SubProjectileCD and SubProjectileTimer.wait_time >= 0.05:
		subshoot.emit(position, rotation_degrees)
		SubProjectileCD = false
		SubProjectileTimer.start()

func _on_projectile_cd_timeout() -> void:
	ProjectileCD = true
	ProjectileTimer.stop()

func _on_sub_projectile_timer_timeout() -> void:
	SubProjectileCD = true
	SubProjectileTimer.stop()
