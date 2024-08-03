extends Node2D
#Performs all operations that affect health
class_name HealthComponent

signal damage_blocked
signal damage_hurt

@onready var animationPlayer = get_node("../AnimationPlayer")
@onready var healthBar = get_node("../HealthBar")

@export var parent:CharacterBody2D
@export var receives_knockback:bool = true
@export var knockback_modifier:float = 5

var maxHP:float = 100
var defence:int = 10
var currentHP:float = maxHP
var isDead:bool = false

func getMaxHP():
	return maxHP
func getHP():
	return currentHP
func getIsDead():
	return isDead

func _ready():
	currentHP = maxHP
	#healthBar.max_value = maxHP
	#initializing parent attributes
	defence =  parent.defence
	maxHP = parent.maxHP

func receive_damage(base_damage:float):
	var actual_damage = base_damage
	#character is alive
	if isDead == false:
		if (actual_damage >= defence):
			currentHP -= actual_damage
			healthBar.value = currentHP
			#healthBar.animate_hp_change = currentHP
			emit_signal("damage_hurt", actual_damage)
		if (actual_damage < defence):
			emit_signal("damage_blocked")
			currentHP = currentHP
	#character is dead
	if currentHP <= 0:
		isDead = true
	elif currentHP != maxHP:
		healthBar.visible = true #only display when damaged
	return actual_damage

func receive_knockback(damage_source_pos: Vector2, received_damage: int):
	if receives_knockback:
		var knockback_direction = damage_source_pos.direction_to(self.global_position)
		var knockback_strength = received_damage * knockback_modifier
		var knockback = knockback_direction * knockback_strength
		
		global_position += knockback
	
#Handles all damage collisions
func _on_hurtbox_area_entered(hitbox):
	if isDead == false:
		var actual_damage = receive_damage(hitbox.dmg)
		
		receive_knockback(hitbox.global_position, actual_damage)
		
