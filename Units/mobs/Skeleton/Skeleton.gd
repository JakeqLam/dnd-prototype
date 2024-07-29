extends CharacterBody2D

class_name Skeleton
@export var health_component : HealthComponent
@onready var selection = $Selection

var follow_cursor:bool = false
var currentHP:int = 100
var defence:int = 5


func _ready():
	defence = health_component.getDef()
	drawEnemyCircle()

func toggle_cursor_state(cursorState: bool):
	follow_cursor = cursorState

func _process(_delta) -> void:
	currentHP = health_component.getHP()

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
