extends CharacterBody2D
#Heavily armored unit with decent damage
class_name Knight

@export var health_component : HealthComponent
@export var wpnRange:int = 25
@export var wpnDmgMin:int = 16
@export var wpnDmgMax:int = 25
@export var wpnSpd:float = 3.0
@export var maxHP:int = 100
@export var defence:int = 5
@export var isPlayer:bool = true

var follow_cursor:bool = false
var currentHP:int = 100
var isDead:bool = false

func toggle_cursor_state(cursorState: bool):
	follow_cursor = cursorState

func _process(_delta):
	isDead = health_component.getIsDead()
	
