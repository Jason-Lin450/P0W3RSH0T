extends Area2D

@onready var LevelUI := get_tree().get_first_node_in_group("levelui")
@onready var Player := get_tree().get_first_node_in_group("player")
@onready var Borders := get_tree().get_nodes_in_group("borders")
@onready var Enemies := get_tree().get_nodes_in_group("enemy")
var hit_enemies: Array[Node2D] = []
var speed
var dmg
var knockback
var bounces
var pierces
var ricochets
var warps

func _ready() -> void:
	speed = Player.projectile_speed
	dmg = Player.dmg
	knockback = Player.knockback
	bounces = Player.bounces
	pierces = Player.pierces
	ricochets = Player.ricochets
	warps = Player.warps

func _physics_process(delta: float) -> void:
	position += global_transform.x.normalized() * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('borders'):
		hit_enemies.clear()
		if (warps > 0):
			if Borders.slice(4, 8).has(body):
				position.x = get_viewport_rect().size.x - position.x
			else:
				position.y = get_viewport_rect().size.y - position.y
			warps -= 1
		elif (bounces > 0):
			if Borders.slice(4, 8).has(body):
				rotation_degrees = 180.0 - rotation_degrees
			else:
				rotation_degrees = -rotation_degrees
			bounces -= 1
		else:
			queue_free()
	elif body.is_in_group('enemy') and !hit_enemies.has(body):
		body.health -= dmg
		body.knockback += global_transform.x.normalized() * knockback
		LevelUI.current_enemy = body
		if (ricochets > 0):
			hit_enemies.clear()
			hit_enemies.append(body)
			Enemies = get_tree().get_nodes_in_group("enemy").filter(func(enemy): return is_instance_valid(enemy) and !hit_enemies.has(enemy))
			if (Enemies.is_empty()):
				rotation_degrees = randf_range(0, 360)
			else:
				look_at(Enemies.pick_random().global_position)
			ricochets -= 1
		elif (pierces > 0):
			hit_enemies.append(body)
			pierces -= 1
		else:
			queue_free()
			return
