extends Node2D

@onready var Player := $Player
@onready var Projectiles := $Projectiles
@onready var SubProjectiles := $SubProjectiles
@onready var Enemies := $Enemies
@onready var Indicators := $Indicators
var projectile_scene: PackedScene = load("res://Scenes/projectile.tscn")
var sub_projectile_scene: PackedScene = load("res://Scenes/sub_projectile.tscn")
var enemy_scene: PackedScene = load("res://Scenes/enemy.tscn")
var indicator_scene: PackedScene = load("res://Scenes/indicator.tscn")

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


func _on_enemy_timer_timeout() -> void:
	#var enemy = enemy_scene.instantiate()
	#Enemies.add_child(enemy)
	
	var indicator = indicator_scene.instantiate()
	Indicators.add_child(indicator)
	indicator.position = get_global_mouse_position()
	#indicator.call("_spawn_enemy", enemy)
	indicator.IndicatorTimer.start()
	print(str(indicator.IndicatorTimer.wait_time))
	if (indicator.IndicatorTimer.wait_time <= 0):
		var enemy = enemy_scene.instantiate()
		Enemies.add_child(enemy)
		enemy.position = get_global_mouse_position()
		enemy.speed = 100
		enemy.maxhealth = 3
		enemy.health = enemy.maxhealth
		enemy.atkdmg = 1
