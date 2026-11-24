extends Marker2D

@onready var IndicatorTimer := $IndicatorTimer
@onready var IndicatorSprite := $IndicatorSprite
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func _spawn_enemy(body: Node2D, ind: Marker2D):
	IndicatorTimer.start()
	var tween = create_tween().set_parallel(true)
	tween.tween_property(ind, 'scale', Vector2(1,1), IndicatorTimer.wait_time).from(Vector2(2, 2))
	tween.tween_property(ind.IndicatorSprite, 'self_modulate:a', 0.1, IndicatorTimer.wait_time).from(0.6)
	await IndicatorTimer.timeout
	body.position = ind.position
	queue_free()
