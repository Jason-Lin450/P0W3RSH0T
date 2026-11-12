extends Area2D

@onready var Enemies := get_tree().get_nodes_in_group("enemy")
@onready var LevelUI := get_tree().get_first_node_in_group("levelui")
var speed = 500
var atkdmg = 0.5

func _ready() -> void:
	scale = Vector2(0.5, 0.5)

func _process(delta: float) -> void:
	position += transform.x * speed * delta * 1/scale

func _on_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		queue_free()
	elif body is CharacterBody2D:
		queue_free()
		for enemy in Enemies:
			if body == enemy:
				enemy.health -= atkdmg
				if (enemy.health > 0):
					LevelUI.EnemyHealthBar.show()
					LevelUI.EnemyHealth.show()
					LevelUI.EnemyHealth.text = str(enemy.health)
					LevelUI.EnemyHealthBar.value = (enemy.health * 1.0/enemy.maxhealth) * 100
				else:
					LevelUI.EnemyHealthBar.hide()
					LevelUI.EnemyHealth.hide()
