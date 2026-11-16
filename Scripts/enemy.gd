extends CharacterBody2D

@onready var Player := get_tree().get_first_node_in_group("player")
@onready var HB := $EnemyHB
@onready var sprite := $EnemySprite
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
	velocity = transform.x * speed
	
	move_and_slide()
	for i in get_slide_collision_count():
		if get_slide_collision_count() > 0 && get_slide_collision(i).get_collider() == Player:
			queue_free()
			Player.health -= dmg
			return
