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

#selecting a unit
func set_selected(value):
	selected = value
	selection.visible = value

