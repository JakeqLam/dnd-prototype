extends CharacterBody2D

class_name Knight
@export var health_component : HealthComponent
@export var rng:int = 25
@export var wpnDmg:int = 5
@export var maxHP:int = 100

var follow_cursor:bool = false
var currentHP:int = 100
var defence:int = 100

var isDead:bool = false

func toggle_cursor_state(cursorState: bool):
	follow_cursor = cursorState

func _process(_delta):
	isDead = health_component.getIsDead()
	
