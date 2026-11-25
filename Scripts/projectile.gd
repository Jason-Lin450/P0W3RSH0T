extends Area2D

@onready var LevelUI := get_tree().get_first_node_in_group("levelui")
@onready var Player := get_tree().get_first_node_in_group("player")
@onready var Borders := get_tree().get_nodes_in_group("borders")
@onready var Enemies := get_tree().get_nodes_in_group("enemy")
var hit_enemies: Array[Node2D]
var speed
var dmg
var bounces
var pierces
var ricochets

func _ready() -> void:
	speed = Player.projectile_speed
	dmg = Player.dmg
	bounces = Player.bounces
	pierces = Player.pierces
	ricochets = Player.ricochets

func _physics_process(delta: float) -> void:
	position += global_transform.x.normalized() * speed * delta / scale

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('borders'):
		hit_enemies.clear()
		if (bounces > 0):
			if Borders.slice(4, 8).has(body):
				rotation_degrees = 180.0 - rotation_degrees
			else:
				rotation_degrees = -rotation_degrees
		else:
			queue_free()
	elif body.is_in_group('enemy') and !hit_enemies.has(body):
		body.health -= dmg
		LevelUI.current_enemy = body
		if (ricochets > 0):
			hit_enemies.clear()
			hit_enemies.append(body)
			look_at(Enemies.pick_random().position)
		if (pierces > 0):
			hit_enemies.append(body)
		else:
			queue_free()
			return
