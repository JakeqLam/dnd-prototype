extends CharacterBody2D

class_name Skeleton

@onready var selection = $Selection
@export var health_component : HealthComponent
@export var wpnRange:int = 20
@export var wpnDmgMin:int = 4
@export var wpnDmgMax:int = 12
@export var wpnSpd:float = 2.5
@export var maxHP:float = 100
@export var defence:int = 10
@export var moveSpeed:int = 40

var currentHP:float = 100
var isDead:bool = false

func _ready():
	pass
	#drawEnemyCircle()

func _process(_delta):
	isDead = health_component.getIsDead()

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
