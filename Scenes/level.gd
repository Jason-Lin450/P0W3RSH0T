extends Node2D

@onready var Player := $Player
@onready var Projectiles := $Projectiles
@onready var SubProjectiles := $SubProjectiles
var projectile_scene: PackedScene = load("res://Scenes/projectile.tscn")
var sub_projectile_scene: PackedScene = load("res://Scenes/sub_projectile.tscn")

func _ready() -> void:
	Player.position = Vector2(352, 480)
	Player.connect('shoot', _on_player_shoot)
	Player.connect('subshoot', _on_player_sub_shoot)

func _process(delta: float) -> void:
	pass
	
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
