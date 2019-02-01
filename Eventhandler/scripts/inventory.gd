extends Node

"""
holds the rubies and a rubies_add function
"""

var rubies = 0

func add_rubies(amount):
	rubies += amount
	eventhandler.emit_signal("on_rubies_earned", amount)