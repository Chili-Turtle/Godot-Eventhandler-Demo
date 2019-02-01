extends Panel

"""
add rubies when on_rubies_earned is emitted
"""

onready var rubies_lab = $rubies_label
onready var rubies_pop = $rubies_popup
onready var pop_animation = $rubies_popup/popup_animation
onready var coin_sound = $AudioStreamPlayer

signal on_ready

func _enter_tree():
	eventhandler.connect("on_update_rubies",self,"update_label")
	eventhandler.connect("on_rubies_earned",self,"add_rubies")
	pass

func _ready():
	eventhandler.emit_signal("on_update_rubies", inventory.rubies)
	is_ready()
	
func is_ready():
	emit_signal("on_ready")

func add_rubies(amount):
	var rubies = rubies_lab.text.to_int()
	rubies += amount
	popup(amount)
#	yield(pop_animation,"animation_finished") #bug
	rubies_lab.text = str(rubies)
	coin_sound.play()
	pass

func popup(amount):
	rubies_pop.text = "%+d" %amount
	pop_animation.play("popup")

func update_label(rubies):
	if rubies_lab == null:
		yield(self,"on_ready")

	rubies_lab.text =  str(rubies)


"""
###################################################################################

this section is used, when you use just signals, but then your rubies_label and rubies_popup
nodes needs a script, with an update rubies and an add_rubies function

###################################################################################

signal on_update_rubies
signal on_add_rubies

func update_label_2(rubies):
	emit_signal("send_rubies",rubies)
	

func add_rubies_2(amount):
	emit_signal("on_add_rubies", amount)
	pass 
"""