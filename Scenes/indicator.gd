extends Marker2D

@onready var IndicatorTimer := $IndicatorTimer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func _spawn_enemy(body: Node2D, ind: Marker2D):
	IndicatorTimer.start()
	create_tween().tween_property(ind, 'scale', Vector2(1,1), IndicatorTimer.wait_time).from(Vector2(0, 0))
	await IndicatorTimer.timeout
	body.position = ind.position
	queue_free()
