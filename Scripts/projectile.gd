extends Area2D

@onready var LevelUI := get_tree().get_first_node_in_group("levelui")
var speed = 500
var atkdmg = 1

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += transform.x * speed * delta / scale

func _on_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		queue_free()
	elif body is CharacterBody2D:
		queue_free()
		if body.is_in_group('enemy'):
			body.health -= atkdmg
			LevelUI.current_enemy = body
