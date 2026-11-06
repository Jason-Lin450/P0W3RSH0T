extends CharacterBody2D

@onready var Player := get_tree().get_first_node_in_group("player") as Node2D
var speed = 100
var health = 2
var dmg = 1

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	look_at(Player.global_position)
	velocity = transform.x * speed
	
	move_and_slide()
	if get_slide_collision(0) && get_slide_collision(0).get_collider() == Player:
		queue_free()
		get_tree().call_group('levelui', '_hit_player', dmg)

func _take_damage(dmg):
	health -= dmg
	if (health <= 0):
		queue_free()
