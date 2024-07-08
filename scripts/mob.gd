extends CharacterBody2D

var speed = 70
var player_chase = false
var player = null

var health = 100
var player_inattack_range = false
var can_take_damage = true
var attack_ip = false

func _physics_process(delta):
	deal_with_damage()
	
	if player_inattack_range:
		attack()
	
	if player_chase == true:
		position += (player.position - position)/speed
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
			if attack_ip == false:
				$AnimatedSprite2D.play("walk")
		else:
			$AnimatedSprite2D.flip_h = false
			if attack_ip == false:
				$AnimatedSprite2D.play("walk")
	else:
		if attack_ip == false and health > 0:
			$AnimatedSprite2D.play("idle")
		
func _ready():
	$AnimatedSprite2D.play("idle")
	
func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass
	
func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_range = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_range = false

func attack():
	if player_inattack_range and health > 0:
		player_chase = false
		attack_ip = true
		$AnimatedSprite2D.play("attack_1")
		$deal_attack_timer.start()

#How much damage the skeleton will receive
func deal_with_damage():
	if player_inattack_range and Global.player_current_attack == true and health != 0:
		if can_take_damage == true:
			health = health - 100
			$receive_damage_cooldown.start()
			can_take_damage = false
			print("skeleton health = ", health)
		if health == 0:
			print("Skeleton has died!")
			$AnimatedSprite2D.play("death")
			
func _on_receive_damage_cooldown_timeout():
	can_take_damage = true

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	attack_ip = false



func _on_death_timer_timeout():
	$death_timer.stop()
