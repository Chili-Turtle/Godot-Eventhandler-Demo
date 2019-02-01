extends Node

"""
counts how many enemey die and how many rubies are earned
"""

var rubies = 0
var enemeys = 0

func _ready():
	eventhandler.connect("on_rubies_earned",self,"set_rubies")
	eventhandler.connect("on_enemy_death",self,"set_enemys_slain")

func set_rubies(amount):
	rubies += amount
	print("total rubies = %d" %rubies)
	
func get_rubies():
	print(rubies)
	
func set_enemys_slain():
	enemeys += 1
	print("total enemeys slain: %d" %enemeys)
	
func get_enemys_slain():
	print(enemeys)