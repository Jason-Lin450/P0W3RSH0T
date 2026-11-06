extends Area2D

var speed = 500
var dmg = 1

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += transform.x * speed * delta * 1/scale

func _on_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		queue_free()
	elif body is CharacterBody2D:
		get_tree().call_group('enemy', '_take_damage', body, dmg)
		queue_free()
	
