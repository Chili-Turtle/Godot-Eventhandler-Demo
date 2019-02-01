extends Node2D

"""
holds hp, damage values and take_damage, on_death and update_hp_bar functions
check if mouse is inside
"""

var Hp = 10
var damage = 1

var is_mouse_inside = false

onready var animation_player = $AnimationPlayer
onready var area = $Area2D
onready var damaged_sound = $AudioStreamPlayer2D

func _ready():
	update_hp_bar()
	area.connect("mouse_entered",self,"on_mouse_entered")
	area.connect("mouse_exited",self,"on_mouse_exited")
	
func on_mouse_entered():
	is_mouse_inside = true
	
func on_mouse_exited():
	is_mouse_inside = false
	
func take_damage(amount,player):
	Hp -= amount
	update_hp_bar()
	animation_player.play("enemy_damaged")
	damaged_sound.play()
	player.take_damage(float("%0.2f" %rand_range(0.1,0.4)))
	
	if Hp <= 0:
		on_death(player)

func on_death(player):
	randomize()
	inventory.add_rubies(randi() %5+6)
	eventhandler.emit_signal("on_enemy_death")
	$Area2D.collision_layer = 2
	visible = false
	pass

func update_hp_bar():
	$ProgressBar.value = Hp
