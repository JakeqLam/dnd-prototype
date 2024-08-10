extends CharacterBody2D
#Heavily armored unit with decent damage
class_name Crossbowman
@export var playerController : PlayerController
@export var health_component : HealthComponent
@export var projectile: PackedScene

@export var wpnRange:int = 150
@export var wpnDmgMin:int = 16
@export var wpnDmgMax:int = 25
@export var wpnSpd:float = 2
@export var maxHP:float = 100
@export var defence:int = 5
@export var moveSpeed:int = 20

@export var isPlayer:bool = true
@export var isSelected:bool = false

var follow_cursor:bool = false
var currentHP:float = 100
var isDead:bool = false
var atkType = "ranged"


func toggle_cursor_state(cursorState: bool):
	follow_cursor = cursorState
func toggle_selected(value: bool):
	isSelected = value
	playerController.enable_selected(value)
	
func _process(_delta):
	isDead = health_component.getIsDead()
	
