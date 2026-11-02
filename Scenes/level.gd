extends Node2D

@onready var Player := $Player
@onready var Projectiles := $Projectiles
@onready var SubProjectiles := $SubProjectiles
@onready var Enemies := $Enemies
var projectile_scene: PackedScene = load("res://Scenes/projectile.tscn")
var sub_projectile_scene: PackedScene = load("res://Scenes/sub_projectile.tscn")
var enemy_scene: PackedScene = load("res://Scenes/enemy.tscn")

func _ready() -> void:
	Player.position = Vector2(352, 480)
	Player.connect('shoot', _on_player_shoot)
	Player.connect('subshoot', _on_player_sub_shoot)

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("test"):
		var enemy = enemy_scene.instantiate()
		Enemies.add_child(enemy)
		enemy.position = get_global_mouse_position()
	
func _on_player_shoot(pos, ang) -> void:
	var projectile = projectile_scene.instantiate()
	Projectiles.add_child(projectile)
	projectile.position = pos
	projectile.rotation_degrees = ang
	
func _on_player_sub_shoot(pos, ang) -> void:
	var subprojectile = sub_projectile_scene.instantiate()
	SubProjectiles.add_child(subprojectile)
	subprojectile.position = pos
	subprojectile.rotation_degrees = ang
