extends Marker2D

@onready var IndicatorSprite := $IndicatorSprite

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func _spawn_enemy(body: Node2D):
	IndicatorSprite.texture = body.sprite.texture
	var duration := 1.0
	var relative_scale = body.sprite.scale / IndicatorSprite.scale
	var tween := create_tween().set_parallel(true)
	tween.tween_property(self, "scale", relative_scale, duration).from(relative_scale * 2)
	tween.tween_property(IndicatorSprite, "self_modulate:a", 0.1, duration).from(0.6)
	await tween.finished
	body.position = position
	queue_free()
	return
