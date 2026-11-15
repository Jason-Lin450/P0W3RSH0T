extends Node2D

@onready var TopBorderLeftHB := $TopBorderLeft/TopBorderLeftHB
@onready var TopBorderRightHB := $TopBorderRight/TopBorderRightHB
@onready var BottomBorderLeftHB := $BottomBorderLeft/BottomBorderLeftHB
@onready var BottomBorderRightHB := $BottomBorderRight/BottomBorderRightHB
@onready var LeftBorderTopHB := $LeftBorderTop/LeftBorderTopHB
@onready var LeftBorderBottomHB := $RightBorderTop/RightBorderTopHB
@onready var RightBorderTopHB := $LeftBorderBottom/LeftBorderBottomHB
@onready var RightBorderBottomHB := $RightBorderBottom/RightBorderBottomHB

func _ready() -> void:
	TopBorderLeftHB.position = Vector2(384, 36)
	TopBorderRightHB.position = Vector2(768, 36)
	BottomBorderLeftHB.position = Vector2(384, 612)
	BottomBorderRightHB.position = Vector2(768, 612)
	LeftBorderTopHB.position = Vector2(188, 184)
	LeftBorderBottomHB.position = Vector2(964, 184)
	RightBorderTopHB.position = Vector2(188, 464)
	RightBorderBottomHB.position = Vector2(964, 464)
