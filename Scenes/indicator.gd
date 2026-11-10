extends Marker2D

@onready var IndicatorTimer := $IndicatorTimer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func _spawn_enemy(body: Node2D):
	pass
	#IndicatorTimer.start()
	#if (IndicatorTimer.wait_time <= 0):
		#body.position = get_global_mouse_position()
		#body.speed = 100
		#body.maxhealth = 3
		#body.health = body.maxhealth
		#body.atkdmg = 1
