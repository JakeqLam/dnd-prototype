extends CharacterBody2D

var enemy_inattack_range = false
var attack_enemy_cooldown = true
var health = 150
var player_alive = true

var attack_ip = false

@export var speed = 100 # How fast the player will move (pixels/sec).

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()
	
	if health <= 0:
		player_alive = false
		health = 0
		print("Player has been killed")
		self.queue_free()
	
func player_movement(delta):
	var animator = $AnimatedSprite2D
	
	#Movement inputs
	if Input.is_action_pressed("move_right"):
		animator.flip_h = false
		animator.play("walk")
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		animator.flip_h = true
		animator.play("walk")
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("move_down"):
		animator.play("walk")
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("move_up"):
		animator.play("walk")
		velocity.y = -speed
		velocity.x = 0
	else:
		if attack_ip == false:
			animator.play("idle")
		velocity.y = 0
		velocity.x = 0
	
	move_and_slide()
	
func attack():
	#Player Attack inputs
	if Input.is_action_just_pressed("attack"):
		attack_ip = true
		Global.player_current_attack = true
		var attacks = ["attack_1","attack_2","attack_3"]
		$AnimatedSprite2D.play(attacks[0])
		$deal_attack_timer.start()

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func player():
	pass

#Enemy attacking the player
func enemy_attack():
	if enemy_inattack_range and attack_enemy_cooldown == true:
		health = health - 10
		attack_enemy_cooldown = false
		$attack_cooldown.start()
		print("Player health: ", health)

#Reset attack cooldown based on the timer node timeout function
func _on_attack_cooldown_timeout():
	attack_enemy_cooldown = true

#Reset attack timer. Prevents attack spam
func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false
