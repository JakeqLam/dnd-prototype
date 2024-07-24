extends CharacterBody2D

@export var maxHP = 100
@export var currentHP = maxHP
@export var defence = 0
@export var speed = 40

@export var selected = false
@onready var selection = $Selection

@onready var animatedSprite = $Sprite2D
@onready var collisionShape = $CollisionShape2D
@onready var animationPlayer = $AnimationPlayer

@onready var target = position
var follow_cursor = false
var Speed = 50

func _ready():
	animationPlayer.play("idle")
	set_selected(selected)

func set_selected(value):
	selected = value
	selection.visible = value

func death():
	queue_free()

func _input(event):
	if event.is_action_pressed("right_click"):
		follow_cursor = true
	if event.is_action_released("right_click"):
		follow_cursor = false

func _physics_process(_delta):
	if follow_cursor == true:
		if selected:
			target = get_global_mouse_position()
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 25:
		animationPlayer.play("walk")
		move_and_slide()
	else:
		animationPlayer.play("idle")
	
