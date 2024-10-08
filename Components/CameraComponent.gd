extends Camera2D

@export var SPEED = 25.0
@export var ZOOM_SPEED = 30.0
@export var ZOOM_MARGIN = 0.1
@export var ZOOM_MIN = 0.5
@export var ZOOM_MAX = 3.0

var zoomFactor = 1.0
var zoomPos = Vector2()
var zooming = false

var mousePos: Vector2 = Vector2()
var mousePosGlobal: Vector2 = Vector2()
var start: Vector2 = Vector2()
var startV: Vector2 = Vector2()
var end: Vector2 = Vector2()
var endV: Vector2 = Vector2()
var isDragging: bool = false

signal unit_select
signal area_selected
signal start_move_selection

@onready var box = get_node("../UI/Panel")
@onready var unitManager = get_node("../UnitManagerComponent")

func _ready():
	box.visible = false
	connect("area_selected", Callable(unitManager, "_on_area_selected"))
	connect("unit_select", Callable(unitManager, "_on_unit_select"))
	
func _process(delta):
	#WASD camera support
	var inputX = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	var inputY = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	position.x = lerp(position.x, position.x + inputX*SPEED * zoom.x, SPEED*delta)
	position.y = lerp(position.y, position.y + inputY*SPEED * zoom.x, SPEED*delta)
	
	zoom.x = lerp(zoom.x, zoom.x * zoomFactor, ZOOM_SPEED*delta)
	zoom.y = lerp(zoom.y, zoom.y * zoomFactor, ZOOM_SPEED*delta)
	
	zoom.x = clamp(zoom.x, ZOOM_MIN, ZOOM_MAX)
	zoom.y = clamp(zoom.y, ZOOM_MIN, ZOOM_MAX)
	
	if not zooming:
		zoomFactor = 1.0
	
	#Set the position of a unit
	if Input.is_action_just_pressed("left_click"):
		start = mousePosGlobal
		startV = mousePos
		isDragging = true
	if isDragging == true:
		end = mousePosGlobal
		endV = mousePos
		draw_area(true)
	if Input.is_action_just_released("left_click"):
		emit_signal("unit_select")
		if startV.distance_to(mousePos) > 20:
			end = mousePosGlobal
			endV= mousePos
			isDragging = false
			draw_area(false)
			emit_signal("area_selected",self)
		else:
			end = start
			isDragging = false
			draw_area(false)
func _input(event):
	
	if abs(zoomPos.x - get_global_mouse_position().x) > ZOOM_MARGIN:
		zoomFactor = 1.0
	if abs(zoomPos.y - get_global_mouse_position().y) > ZOOM_MARGIN:
		zoomFactor = 1.0

	if event is InputEventMouseButton:
		if event.is_pressed():
			zooming = true
			if event.is_action("wheel_down"):
				zoomFactor -= 0.08 * ZOOM_SPEED
				zoomPos = get_global_mouse_position()
			if event.is_action("wheel_up"):
				zoomFactor += 0.08 * ZOOM_SPEED
				zoomPos = get_global_mouse_position()
		else:
			zooming = false
			
	
	if event is InputEventMouse:
		mousePos = event.position
		mousePosGlobal = get_global_mouse_position()
 
func draw_area(s=true):
	box.visible = true
	box.size = Vector2(abs(startV.x - endV.x), abs(startV.y - endV.y))
	var pos = Vector2()
	pos.x = min(startV.x, endV.x)
	pos.y = min(startV.y, endV.y)
	box.position = pos
	box.size *= int(s)
