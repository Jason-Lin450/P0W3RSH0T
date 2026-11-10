extends CanvasLayer

@onready var PlayerHealthBar := $PlayerHealthBar
@onready var PlayerHealth := $PlayerHealthBar/PlayerHealth
@onready var EnemyHealthBar := $EnemyHealthBar
@onready var EnemyHealth := $EnemyHealthBar/EnemyHealth
@onready var PowerIcon := $PowerIcon
@onready var MapIcon := $MapIcon
@onready var ModsIcon := $ModsIcon

func _ready() -> void:
	PlayerHealthBar.value = 100
	PlayerHealth.text = str(PlayerHealthBar.value)
	PlayerHealthBar.position = Vector2(16, 16)
	EnemyHealthBar.hide()
	EnemyHealth.hide()
	EnemyHealthBar.position = Vector2(216, 64)
	PowerIcon.position = Vector2(24, 448)
	MapIcon.position = Vector2(24, 400)
	ModsIcon.position = Vector2(24, 352)

func _process(delta: float) -> void:
	PlayerHealth.text = str(PlayerHealthBar.value)
