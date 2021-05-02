extends Node

# Usage:
# 1) Add all scenes to load with add_resource_to_query(_name, path)
# 2) Start scenes load with start_load()
# 3) Get resources by name with get_resource(_name)

var resources_queue = []		# [ {"name": "name", "path": "path", "completed": false} ]
var loaded_resources = {}		# { "name": resource }

var loading_screen = null

const SIMULATED_DELAY_SEC = 0.1

var thread = null

func add_resource_to_query(_name: String, path: String):
	resources_queue.append( {"name": _name, "path": path} )
	pass

func start_load():
	if not resources_queue.empty():
		loaded_resources = {}
		var path = resources_queue[0]["path"]
		load_scene(path)
	pass

func get_resource(_name: String):
	return loaded_resources[_name]

func _thread_load(path):
	print("Thread loading: ", path)
	var ril = ResourceLoader.load_interactive(path)
#	var ril = ResourceLoader.load_interactive(path)
	assert(ril)
#	var total = ril.get_stage_count()
	# Call deferred to configure max load steps.
#	progress.call_deferred("set_max", total)

	var res = null

	while true: #iterate until we have a resource
		# Update progress bar, use call deferred, which routes to main thread.
#		progress.call_deferred("set_value", ril.get_stage())
		# Simulate a delay.
#		OS.delay_msec(int(SIMULATED_DELAY_SEC * 1000.0))
		# Poll (does a load step).
		var err = ril.poll()
		# If OK, then load another one. If EOF, it' s done. Otherwise there was an error.
		if err == ERR_FILE_EOF:
			# Loading done, fetch resource.
			res = ril.get_resource()

			# Storage fetched resource
			var _name = resources_queue[0]["name"]
			loaded_resources[_name] = res
			print("Resource loaded: ", _name)

			resources_queue.pop_front()

				# Load next scene
			if not resources_queue.empty():
#				thread.wait_to_finish()
				load_scene( resources_queue[0]["path"] )
				break
		elif err != OK:
			# Not OK, there was an error.
			print("There was an error loading")
			break

	# Send whathever we did (or did not) get.
	call_deferred("_thread_done", res)


func _thread_done(resource):
	print("Thread done: ", resource)
	assert(resource)

	# Always wait for threads to finish, this is required on Windows.
	thread.wait_to_finish()

	print(loaded_resources)
	loading_screen._on_loading_ready()

func load_scene(path):
	print("Started loading: ", path)
	thread = Thread.new()
	thread.start( self, "_thread_load", path)
#
#func load_next_on_queue():
#	if not resources_queue.empty():
#		print("Loading next on Queue")
#		load_scene( resources_queue[0] )
#	else:
#		if loading_screen:
#			print("Changing to Loading Screen")
#			loading_screen.on_loading_ready()

#var load_running = false
#var load_ended = true
#
#var level = null
#
#func _ready():
#	pass
#
#func _process(delta: float) -> void:
#	if load_running:
#
#		for res in resources_list:
#			if not res["completed"]:
#				if not loaded_resources[ res["name"] ]:
#					print("RQ: ", res["path"])
#					var loaded_res = ResourceQueue.get_resource( res["path"] )
#					if loaded_res:
#						loaded_resources[ res["name"] ] = loaded_res
#						res["completed"] = true
#
#		if get_progress() == 1.0:
#			load_ended = true
#			resources_list.clear()
#		pass
#
#func has_ended() -> bool:
#	return load_ended
#
#func add_resource_to_queue(_name: String, _path: String):
#	resources_list.append( {"name": _name, "path": _path, "completed": false} )
#	ResourceQueue.queue_resource(_path)
#
#func get_resource(_name: String):
#	return loaded_resources[_name]
#
#func get_progress():
#	var total_progress = 0.0
#	for resource in resources_list:
#		var progress = ResourceQueue.get_progress(resource["path"])
#		total_progress += progress
#	total_progress /= resources_list.size()
#
#	return total_progress	# Between 0.0 and 1.0
#
#func start_load():
#	ResourceQueue.start()
#	load_running = true
#	load_ended = false
# -----
#var load_queue = []		# [ {"name": "name", "path": "path"} ]
#
#var loaded: Dictionary = {}
#
#var load_in_progress = false
#var res_loading = false
#var current_load_index = 0

#func _ready() -> void:
#	pass
#
#func add_to_load_queue(_name: String, _path: String):
#	if not load_in_progress:
#		load_queue.append( {"name": _name, "path": _path} )
#
#func start_load():
#	load_in_progress = true
#	pass
#
#func _process(delta: float) -> void:
#	if load_in_progress:
#		var curr_load_res = load_queue[current_load_index]
#		var curr_key = curr_load_res["name"]
#		var curr_path = curr_load_res["path"]
#
#		if loaded[curr_key]:
#			current_load_index += 1
#			res_loading = false
#
#		elif not res_loading:
#			loaded[curr_key] = load(curr_path)
#			res_loading = true
#	pass
#
#func _is_fully_loaded() -> bool:
#	for key in loaded.keys():
#		print(loaded[key])
#		if not loaded[key]:
#			return false
#	return true
