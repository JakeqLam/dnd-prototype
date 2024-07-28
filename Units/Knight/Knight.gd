extends CharacterBody2D

class_name Knight

var follow_cursor:bool = false

func _ready():
	pass

func toggle_cursor_state(cursorState: bool):
	follow_cursor = cursorState
