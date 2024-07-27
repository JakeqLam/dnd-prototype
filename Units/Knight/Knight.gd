extends "res://Units/Unit.gd"

class_name Knight

@onready var collisionShape = $CollisionShape2D

var unit = Unit.new()

func _init():
	#Initialize base stats
	unit.weaponDamage = 5
	unit.currentHP = 20
	unit.defence = 20
	unit.speed = 40

"""
func _input(event):
	if event.is_action_pressed("right_click"):
		unit.follow_cursor = true
		var clickTarget = get_global_mouse_position()
		unit.set_target(clickTarget)
	if event.is_action_released("right_click"):
		unit.follow_cursor = false


func _physics_process(_delta):
	if follow_cursor == true:
		if selected:
			target = get_global_mouse_position()
	
	velocity = position.direction_to(target) * unit.speed
	
	if((unit.isAttacking == false) and (unit.isDead == false) and (unit.isUnderAttack == false)):
		if position.distance_to(target) > 10:
			if position.x > target.x:
				animatedSprite.flip_h = true
			elif position.x < target.x:
				animatedSprite.flip_h = false
			animationPlayer.play("walk")
			move_and_slide()
		else:
			animationPlayer.play("idle")
"""
	
func _on_animation_player_animation_finished(anim_name):
	if ("attack01" in anim_name):
		unit.isAttacking = false
	elif ("block" in anim_name):
		unit.isUnderAttack = false
	elif ("hurt" in anim_name):
		unit.isUnderAttack = false
	elif ("death" in anim_name):
		animationPlayer.stop()





#Chase Enemy units
func _on_enemy_detector_body_entered(body):
	if body.is_in_group("enemyUnits"):
		#Chase enemy unit to attack in melee range
		isChasing = true
		print(body)
	
#Enemy is within melee range
func _on_attack_range_body_entered(body):
	if body.is_in_group("enemyUnits"):
		print("I am within critical distance!")
		isAttacking = true
		animationPlayer.play("attack01")
