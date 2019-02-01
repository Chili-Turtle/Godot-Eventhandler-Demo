extends Control

"""
laods the scene
"""

var loader
var wait_frames
var time_max = 100
var current_scene

func _ready():
	pass

func _on_exit_pressed():
	get_tree().quit()

func _on_start_button_pressed():
	goto_screen("res://level/Level_1.tscn")

func goto_screen(path):
	call_deferred("loading_screen", path)

func loading_screen(path):
	loader = ResourceLoader.load_interactive(path)

	if loader == null:
		show_error()
		return

	set_process(true)
	wait_frames = 1

func _process(delta):
	if loader == null:
		set_process(false)
		return

	if wait_frames > 0:
		wait_frames -= 1
		return

	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max:
		var err = loader.poll()

		if err == ERR_FILE_EOF:
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			break
		if err == OK:
			update_progress()
		else:
			show_error()
			loader == null
			break

func set_new_scene(scene_resource):
	current_scene = scene_resource.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 2).queue_free()


func update_progress():
	var progress = float(loader.get_stage()/ loader.get_stage_count())
	print(progress)

func show_error():
    print(loader.get_stage_count(), " this is an error")