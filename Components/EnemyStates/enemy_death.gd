extends State
class_name EnemyDeath
@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var hurtboxCol = get_node("../../HurtboxComponent/CollisionShape2D")
@onready var colShape = get_node("../../CollisionShape2D")
@onready var enemDet = get_node("../../EnemyDetector/CollisionShape2D")
@onready var hitbox = get_node("../../HitboxComponent/CollisionShape2D")

@export var enemy: CharacterBody2D

func Enter():
	animationPlayer.play("death")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death":
		hurtboxCol.disabled = true
		colShape.disabled = true
		enemDet.disabled = true
		hitbox.disabled = true
