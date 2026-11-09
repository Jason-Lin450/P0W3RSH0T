extends CharacterBody2D

@onready var Player := get_tree().get_first_node_in_group("player")
@onready var LevelUI := get_tree().get_first_node_in_group("levelui")
var speed
var health
var atkdmg

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if (health <= 0):
		queue_free()
	
	look_at(Player.global_position)
	velocity = transform.x * speed
	
	move_and_slide()
	if get_slide_collision(0) && get_slide_collision(0).get_collider() == Player:
		queue_free()
		LevelUI.PlayerHealthBar.value -= atkdmg
