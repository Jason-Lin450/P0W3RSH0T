extends CharacterBody2D

@onready var Player := get_tree().get_first_node_in_group("player")
@onready var HB := $EnemyHB
@onready var sprite := $EnemySprite
var knockback := Vector2(0, 0)
var knockback_dampen = 1000
var speed
var health
var maxhealth
var dmg

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if (health <= 0):
		queue_free()
		return
	
	look_at(Player.global_position)
	velocity = transform.x * speed + knockback
	knockback = knockback.move_toward(Vector2.ZERO, knockback_dampen * delta)
	if (knockback.x < 0.1 && knockback.x > -0.1):
		knockback.x = 0
	if (knockback.y < 0.1 && knockback.y > -0.1):
		knockback.y = 0
	
	move_and_slide()
	for i in get_slide_collision_count():
		if get_slide_collision_count() > 0 && get_slide_collision(i).get_collider() == Player:
			queue_free()
			Player.health -= dmg
			return
