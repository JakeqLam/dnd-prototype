extends "res://Units/Unit.gd"

@onready var animatedSprite = $Sprite2D
@onready var collisionShape = $CollisionShape2D
@onready var animationPlayer = $AnimationPlayer
@onready var target = position

@export var player: CharacterBody2D

var follow_cursor:bool = false
var unit = Unit.new()

#State Management Variables
var isDying:bool = false
var isAttacking:bool = false
var isUnderAttack:bool = false
var isChasing:bool = false

func _init():
	#Initialize base stats
	unit.weaponDamage = 5
	unit.currentHP = 20
	unit.defence = 20
	unit.speed = 40
	
func _physics_process(delta):
	
	#Chase Mechanics
	#var target = Vector2()
	if is_instance_valid(player):
		target = player.get_position()
		#if isChasing == true:
			#velocity = position.direction_to(target) * unit.speed
		
	if((isAttacking == false) and (isDying == false) and (isUnderAttack == false)):
		if position.distance_to(target) > 10:
			if position.x > target.x:
				animatedSprite.flip_h = true
			elif position.x < target.x:
				animatedSprite.flip_h = false
			animationPlayer.play("walk")
			move_and_slide()
		else:
			animationPlayer.play("idle")

func attack(damage):
	isAttacking = true
	animationPlayer.play("attack01")
	
func hit(damage):
	isUnderAttack = true
	if (damage >= unit.defence):
		currentHP -= damage
		animationPlayer.play("hurt")
	if (damage < unit.defence):
		animationPlayer.play("block")
	if (currentHP <= 0):
		isDying = true
		if(isDying == true):
			animationPlayer.play("death")

func _on_animation_player_animation_finished(anim_name):
	if ("attack01" in anim_name):
		isAttacking = false
	elif ("block" in anim_name):
		isUnderAttack = false
	elif ("hurt" in anim_name):
		isUnderAttack = false
	elif ("death" in anim_name):
		animationPlayer.stop()
		self.queue_free()

func _on_enemy_detector_body_entered(body):
	if body.is_in_group("playerUnits"):
		#Chase enemy unit to attack in melee range
		#isChasing = true
		player = body
		print("player has entered range")

func _on_attack_collider_body_entered(body):
	isChasing = false
	isAttacking = true
	attack(unit.weaponDamage)
