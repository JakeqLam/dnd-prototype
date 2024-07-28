extends CharacterBody2D

class_name Knight
@export var health_component : HealthComponent

var follow_cursor:bool = false
var currentHP:int = 100
var defence:int = 5


func _ready():
	defence = health_component.getDef()

func toggle_cursor_state(cursorState: bool):
	follow_cursor = cursorState

func _process(_delta):
	currentHP = health_component.getHP()
