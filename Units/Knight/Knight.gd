extends "res://Units/Unit.gd"

class_name Knight

@onready var animatedSprite = $Sprite2D
@onready var collisionShape = $CollisionShape2D
@onready var animationPlayer = $AnimationPlayer
@onready var target = position

var follow_cursor:bool = false
var unit = Unit.new()

#State Management Variables
var isDying:bool = false
var isAttacking:bool = false
var isUnderAttack:bool = false

func _init():
	#Initialize base stats
	unit.weaponDamage = 5
	unit.currentHP = 20
	unit.defence = 20
	unit.speed = 40
	
func _input(event):
	if event.is_action_pressed("right_click"):
		follow_cursor = true
	if event.is_action_released("right_click"):
		follow_cursor = false

func _physics_process(_delta):
	if follow_cursor == true:
		if selected:
			target = get_global_mouse_position()
	velocity = position.direction_to(target) * unit.speed
	
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

func _on_attack_detector_body_entered(body):
	attack(unit.weaponDamage)

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
	if ("Skeleton" in body.name):
		print("Skeleton unit in range!")
		#Chase enemy unit to attack in melee range
		velocity = position.direction_to(body.position) * unit.speed
		
