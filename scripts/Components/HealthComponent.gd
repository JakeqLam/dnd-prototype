extends Node2D
#Performs all operations that affect health
class_name HealthComponent

signal damage_blocked
signal damage_hurt

@onready var animationPlayer = get_node("../AnimationPlayer")
@export var parent:CharacterBody2D

var maxHP:int = 100
var defence:int = 10
var currentHP:int = maxHP
var isDead:bool = false

func getMaxHP():
	return maxHP
func getHP():
	return currentHP
func getIsDead():
	return isDead

func _ready():
	currentHP = maxHP
	
	#initializing parent attributes
	defence =  parent.defence
	maxHP = parent.maxHP

func receive_damage(base_damage:int):
	var actual_damage = base_damage
	#character is alive
	if isDead == false:
		if (actual_damage >= defence):
			currentHP -= actual_damage	
			emit_signal("damage_hurt")
		if (actual_damage < defence):
			emit_signal("damage_blocked")
			currentHP = currentHP
	#character is dead
	if currentHP <= 0:
		isDead = true
	#print(name + " received "+ str(actual_damage) + " damage " + "current health: " + str(currentHP))
	
func _on_hurtbox_area_entered(hitbox):
	if isDead == false:
		hitbox.damage = randi_range(5,40)
		receive_damage(hitbox.damage)
