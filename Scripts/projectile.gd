extends Area2D

@onready var LevelUI := get_tree().get_first_node_in_group("levelui")
@onready var Player := get_tree().get_first_node_in_group("player")
@onready var Borders := get_tree().get_nodes_in_group("borders")
var speed
var dmg
var bounces

func _ready() -> void:
	speed = Player.projectile_speed
	dmg = Player.dmg
	bounces = Player.bounces

func _physics_process(delta: float) -> void:
	position += global_transform.x.normalized() * speed * delta / scale

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('borders') and get_overlapping_bodies().size() < 2:
		if (bounces > 0):
			if Borders.slice(4, 8).has(body):
				rotation_degrees = 180.0 - rotation_degrees
			else:
				rotation_degrees = -rotation_degrees
		else:
			queue_free()
	elif body.is_in_group('enemy'):
		queue_free()
		body.health -= dmg
		LevelUI.current_enemy = body
