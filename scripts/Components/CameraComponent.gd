extends Node


@export var selected:bool = false
@export var isPlayer:bool = true #Check if this unit is owned by the player

@onready var selection = $Selection
#@onready var hurtbox = $HurtboxComponent
@onready var animationPlayer = $AnimationPlayer
@onready var sprite = $Sprite2D

#selecting a unit
func set_selected(value):
	selected = value
	if isPlayer == true:
		selection.visible = value
	elif isPlayer == false:
		drawEnemyCircle()
		selection.visible = value

func drawEnemyCircle():
		var style:StyleBoxFlat = StyleBoxFlat.new()
		style.border_color =  Color(1,0,0,0.86) #red
		style.bg_color =  Color(0.86,0,0,0)
		style.anti_aliasing = false
		style.set_border_width_all(2)
		style.corner_detail = 20
		style.set_corner_radius_all(20)
		style.border_blend = true
		selection.add_theme_stylebox_override("panel", style)
