extends CharacterBody2D
#Heavily armored unit with decent damage
class_name Knight

@export var health_component : HealthComponent
@export var playerController : PlayerController

@export var wpnRange:int = 30
@export var wpnDmgMin:int = 16
@export var wpnDmgMax:int = 25
@export var wpnSpd:float = 2
@export var maxHP:float = 100
@export var defence:int = 5
@export var isPlayer:bool = true
@export var moveSpeed:int = 20

var follow_cursor:bool = false
var currentHP:float = 100
var isDead:bool = false
var atkType = "melee"

func toggle_cursor_state(cursorState: bool):
	follow_cursor = cursorState
func toggle_selected(isSelected: bool):
	playerController.set_selected(isSelected)
	
func _process(_delta):
	isDead = health_component.getIsDead()
	
