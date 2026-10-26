extends CharacterBody2D

const SPEED = 300.0

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * SPEED
	move_and_slide()
