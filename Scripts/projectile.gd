extends Area2D

var speed = 500

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += transform.x * speed * delta * 1/scale

func _on_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		queue_free()
	elif body is CharacterBody2D:
		queue_free()
	
