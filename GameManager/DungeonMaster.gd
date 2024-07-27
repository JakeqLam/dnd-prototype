extends Node2D

#This class is used to manage all aspects of the game
class_name DungeonMaster

var playerUnits = []
var enemyUnits = []

func _ready():
	playerUnits = get_tree().get_nodes_in_group("playerUnits")
	enemyUnits = get_tree().get_nodes_in_group("enemyUnits")
	
func _on_area_selected(object):
	var start = object.start
	var end = object.end
	var area = []
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	var ut = get_units_in_area(area)
	
	for u in playerUnits:
		u.set_selected(false)
	for u in ut:
		u.set_selected(!u.selected)

func _on_unit_select():
	var target = get_global_mouse_position()
	
	#De-select units
	for u in playerUnits:
		u.set_selected(false)
	for u in enemyUnits:
		u.set_selected(false)
	
	#Search groups to grab the closest unit
	get_closest_unit(playerUnits, target)
	get_closest_unit(enemyUnits, target)

#Search through a group and select the closest unit to a give target
func get_closest_unit(units, target):
	#Select the closest unit within 10px
	for unit in units:
		var unitX = unit.position.x - target.x
		var unitY = unit.position.y - target.y
		if (unitX < 10) and (unitX > -10):
			if(unitY < 10) and (unitY > -10):
				unit.set_selected(!unit.selected)
	
#Grabbing units in a drag box
func get_units_in_area(area):
	var u = []
	#Check the x and y position of unit and see if they are located in that box
	for unit in playerUnits:
		if (unit.position.x > area[0].x) and (unit.position.x < area[1].x):
			if (unit.position.y > area[0].y) and (unit.position.y < area[1].y):
				u.append(unit)
	return u
