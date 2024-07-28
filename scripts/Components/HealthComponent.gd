extends Node2D

class_name HealthComponent

signal damage_blocked
signal damage_hurt

@onready var animationPlayer = get_node("../AnimationPlayer")
@onready var sprite = get_node("../Sprite2D")

@export var maxHP:int = 100
@export var defence:int = 8

var currentHP:int = maxHP

func getMaxHP():
	return maxHP
func getHP():
	return currentHP
func getDef():
	return defence

func _ready():
	currentHP = maxHP

func receive_damage(base_damage:int):
	var actual_damage = base_damage
	if (actual_damage >= defence):
		currentHP -= actual_damage	
		emit_signal("damage_hurt")
	if (actual_damage < defence):
		emit_signal("damage_blocked")
		currentHP = currentHP

	print(name + " received "+ str(actual_damage) + " damage " + "current health: " + str(currentHP))
	
func _on_hurtbox_area_entered(hitbox):
	hitbox.damage = randi_range(5,10)
	receive_damage(hitbox.damage)
