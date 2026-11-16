extends CanvasLayer

@onready var Player := get_tree().get_first_node_in_group("player")
@onready var PlayerHealthBar := $PlayerHealthBar
@onready var PlayerHealth := $PlayerHealthBar/PlayerHealth
@onready var EnemyHealthBar := $EnemyHealthBar
@onready var EnemyHealth := $EnemyHealthBar/EnemyHealth
@onready var PowerIcon := $PowerIcon
@onready var MapIcon := $MapIcon
@onready var ModsIcon := $ModsIcon
var current_enemy: CharacterBody2D = null

func _ready() -> void:
	PlayerHealthBar.value = Player.health * 100 / Player.max_health
	PlayerHealth.text = str(PlayerHealthBar.value)
	#PlayerHealthBar.position = Vector2(16, 16)
	#EnemyHealthBar.position = Vector2(216, 64)
	#PowerIcon.position = Vector2(24, 448)
	#MapIcon.position = Vector2(24, 400)
	#ModsIcon.position = Vector2(24, 352)

func _process(delta: float) -> void:
	PlayerHealthBar.value = Player.health
	PlayerHealth.text = str(PlayerHealthBar.value)
	if !is_instance_valid(current_enemy) or current_enemy.health <= 0:
		EnemyHealthBar.hide()
		EnemyHealth.hide()
	else:
		EnemyHealthBar.show()
		EnemyHealth.show()
		EnemyHealth.text = str(current_enemy.health)
		EnemyHealthBar.value = (current_enemy.health * 1.0/current_enemy.maxhealth) * 100
