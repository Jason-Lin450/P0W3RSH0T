extends Node2D

#top_left = (192, 40)
#top_right = (960, 40)
#bottom_left = (192, 608)
#bottom_right = (960, 608)
@onready var Player := $Player
@onready var Projectiles := $Projectiles
@onready var SubProjectiles := $SubProjectiles
@onready var Enemies := $Enemies
@onready var Indicators := $Indicators
@onready var EnemyTimer := $EnemyTimer
var projectile_scene := preload("res://Scenes/projectile.tscn")
var sub_projectile_scene := preload("res://Scenes/sub_projectile.tscn")
var enemy_scene := preload("res://Scenes/enemy.tscn")
var indicator_scene := preload("res://Scenes/indicator.tscn")
var rng := RandomNumberGenerator.new()
var enemy_maxhealth = 3
var enemy_speed = 100
var enemy_dmg = 1

func _ready() -> void:
	rng.randomize()
	Player.position = Vector2(352, 480)
	Player.shoot.connect(_on_player_shoot)
	Player.subshoot.connect(_on_player_sub_shoot)
	EnemyTimer.wait_time = 2
	EnemyTimer.start()

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
	var enemy = enemy_scene.instantiate()
	Enemies.add_child(enemy)
	enemy.visible = false
	enemy.process_mode = Node.PROCESS_MODE_DISABLED
	enemy.maxhealth = enemy_maxhealth
	enemy.health = enemy.maxhealth
	enemy.speed = enemy_speed
	enemy.dmg = enemy_dmg
	var indicator = indicator_scene.instantiate()
	Indicators.add_child(indicator)
	var radius = enemy.HB.shape.radius
	var indicatorposition = Vector2(rng.randi_range(192 + radius, 960 - radius), rng.randi_range(40 + radius, 608 - radius))
	
	while (indicatorposition.distance_squared_to(Player.position) < 250 * 250):
		indicatorposition = Vector2(rng.randi_range(192 + radius, 960 - radius), rng.randi_range(40 + radius, 608 - radius))
	
	indicator.position = indicatorposition
	indicator._spawn_enemy(enemy)
