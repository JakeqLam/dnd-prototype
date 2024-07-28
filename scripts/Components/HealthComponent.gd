extends Node2D

class_name HealthComponent

@onready var animationPlayer = get_node("../AnimationPlayer")
@onready var sprite = get_node("../Sprite2D")

@export var maxHP:int = 100
@export var defence:int = 0
@export var speed:int = 20
@export var weaponDamage:int = 1

var currentHP:int = maxHP

var isDead:bool = false
var isAttacking:bool = false
var isUnderAttack:bool = false
var isChasing:bool = false

func _ready():
	currentHP = maxHP
func death():
	animationPlayer.play("death")
	print(name + "has died!")

func receive_damage(base_damage:int):
	self.isUnderAttack = true
	var actual_damage = base_damage
	if (actual_damage >= defence):
		currentHP -= actual_damage

	#if (actual_damage < defence):

	if (currentHP <= 0):
		death()
	
	self.currentHP -= actual_damage
	print(name + " received "+ str(actual_damage) + " damage " + "current health: " + str(currentHP))
	
func _on_hurtbox_area_entered(hitbox):
	receive_damage(hitbox.damage)
