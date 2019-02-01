extends ProgressBar

"""
subtracts from hp bar when on_update_player_hp is emitted
"""

onready var animation_player = $AnimationPlayer
onready var popup = $player_popup
onready var popup_animation = $player_popup/popup_animation

func _init():
	eventhandler.connect("on_update_player_hp",self,"update_bar")
	eventhandler.connect("on_player_hit",self,"take_damage")
	pass

func _ready():
	pass

func take_damage(amount):
	value -= amount
	animation_player.play("ui_player_damaged")
	popup.text = "%+.1f" %-amount
	popup_animation.play("popup_player")

func update_bar(hp):
	value = hp
