extends Node2D

"""
holds health, damge values and a take_damage func
shoots a ray to check if it hits a collider
"""

var health = 10
var damage = 1

onready var ray = $RayCast2D
onready var hitsound = $AudioStreamPlayer

func _ready():
	eventhandler.emit_signal("on_update_player_hp",health)
	pass

func _input(event):
	if event.is_action_pressed("attack"):
		attack()

func attack():
	hitsound.play()
	ray.set_cast_to(get_local_mouse_position())
	ray.force_raycast_update()
	if ray.is_colliding() and ray.get_collider().get_parent():
		if ray.get_collider().get_parent().has_method("take_damage") and ray.get_collider().get_parent().is_mouse_inside:
			ray.get_collider().get_parent().take_damage(damage,self)
	pass

func take_damage(amount):
	health -= amount
	eventhandler.emit_signal("on_player_hit",amount)