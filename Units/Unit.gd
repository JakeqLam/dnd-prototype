extends CharacterBody2D

class_name Unit

@export var maxHP:int = 100
@export var currentHP:int = maxHP
@export var defence:int = 0
@export var speed:int = 20
@export var weaponDamage:int = 1

@export var selected:bool = false
@export var isPlayer:bool = true #Check if this unit is owned by the player

@onready var selection = $Selection
#@onready var hurtbox = $HurtboxComponent
@onready var animationPlayer = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var target = position

enum unitState {
	IDLING, MOVING, CHASING, ATTACKING, DEATH, BLOCKING, HURTING
}
@export var current_state = unitState["IDLING"] : set=set_state, get=get_state
var isDead:bool = false
var isAttacking:bool = false
var isUnderAttack:bool = false
var isChasing:bool = false

var follow_cursor:bool = false

func _input(event):
	if event.is_action_pressed("right_click"):
		follow_cursor = true
		var clickTarget = get_global_mouse_position()
		set_target(clickTarget)
	if event.is_action_released("right_click"):
		follow_cursor = false

func _ready():
	set_selected(selected) #init to false
func _physics_process(_delta):
	match current_state:
		unitState["IDLING"]:
			animationPlayer.play("idle")
		unitState["MOVING"]:
			velocity = position.direction_to(target) * speed
			
			if position.distance_to(target) > 10:
				if position.x > target.x:
					sprite.flip_h = true
				elif position.x < target.x:
					sprite.flip_h = false
			animationPlayer.play("walk")
			move_and_slide()
		unitState["ATTACKING"]:
			animationPlayer.play("attack01")
		unitState["DEATH"]:
			animationPlayer.play("death")
		unitState["BLOCKING"]:
			animationPlayer.play("block")
		unitState["HURTING"]:
			animationPlayer.play("hurt")
func get_state():
	return current_state
func set_state(state):
	current_state = state
	
func set_target(clickTarget:Vector2):
	self.current_state = unitState["MOVING"]
	target = clickTarget

func set_player(value):
	isPlayer = value

#selecting a unit
func set_selected(value):
	selected = value
	if isPlayer == true:
		selection.visible = value
	elif isPlayer == false:
		drawEnemyCircle()
		selection.visible = value

func drawEnemyCircle():
		var style:StyleBoxFlat = StyleBoxFlat.new()
		style.border_color =  Color(1,0,0,0.86) #red
		style.bg_color =  Color(0.86,0,0,0)
		style.anti_aliasing = false
		style.set_border_width_all(2)
		style.corner_detail = 20
		style.set_corner_radius_all(20)
		style.border_blend = true
		selection.add_theme_stylebox_override("panel", style)

func death():
	isDead = true
	animationPlayer.play("death")
	#print(name + "has died!")

func receive_damage(base_damage:int):
	self.isUnderAttack = true
	var actual_damage = base_damage
	if (actual_damage >= defence):
		currentHP -= actual_damage
		self.set_state("HURTING")
	if (actual_damage < defence):
		self.set_state("BLOCKING")
	if (currentHP <= 0):
		death()
	
	self.currentHP -= actual_damage
	#print(name + " received "+ str(actual_damage) + " damage " + "current health: " + str(currentHP))
	
func _on_hurtbox_area_entered(hitbox):
	receive_damage(hitbox.damage)
