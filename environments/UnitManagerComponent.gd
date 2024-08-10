extends Node2D

var playerUnits = []

func _ready():
	playerUnits = get_tree().get_nodes_in_group("player")

func _on_unit_select():
	var target = get_global_mouse_position()
	for u in playerUnits:
		u.toggle_selected(false)
	#Select the closest unit within 10px
	for unit in playerUnits:
		var unitX = unit.position.x - target.x
		var unitY = unit.position.y - target.y

		if (unitX < 10) and (unitX > -10):
			if(unitY < 10) and (unitY > -10):
				print("true")
				unit.toggle_selected(true)
func _on_area_selected(object):
	var start = object.start
	var end = object.end
	var area = []
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	var ut = get_units_in_area(area)
	
	for u in playerUnits:
		u.toggle_selected(false)
	for u in ut:
		u.toggle_selected(true)
		
#Grabbing units in a drag box
func get_units_in_area(area):
	var u = []
	#Check the x and y position of unit and see if they are located in that box
	for unit in playerUnits:
		if (unit.position.x > area[0].x) and (unit.position.x < area[1].x):
			if (unit.position.y > area[0].y) and (unit.position.y < area[1].y):
				u.append(unit)
	return u
