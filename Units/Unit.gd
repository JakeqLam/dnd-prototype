extends CharacterBody2D

class_name Unit

@export var maxHP:int = 100
@export var currentHP:int = maxHP
@export var defence:int = 0
@export var speed:int = 0
@export var weaponDamage:int = 0

@export var selected:bool = false
@export var isPlayer:bool = true #Check if this unit is owned by the player

@onready var selection = $Selection

func _ready():
	set_selected(selected) #init to false

func set_player(value):
	isPlayer = value
	print(isPlayer)

#selecting a unit
func set_selected(value):
	print("selecting!")
	selected = value
	if isPlayer == true:
		selection.visible = value
	elif isPlayer == false:
		drawEnemyCircle()
		selection.visible = value

func drawEnemyCircle():
		print("draw!!")
		var style:StyleBoxFlat = StyleBoxFlat.new()
		style.border_color =  Color(1,0,0,0.86) #red
		style.bg_color =  Color(0.86,0,0,0)
		style.anti_aliasing = false
		style.set_border_width_all(2)
		style.corner_detail = 20
		style.set_corner_radius_all(20)
		style.border_blend = true
		selection.add_theme_stylebox_override("panel", style)
