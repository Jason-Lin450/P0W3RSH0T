extends CharacterBody2D

@onready var Player := get_tree().get_first_node_in_group("player") as Node2D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	look_at(Player.global_position)
	move_and_collide(Vector2())
