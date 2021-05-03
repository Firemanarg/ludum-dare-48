extends Node

# Usage:
# 1) Add all scenes to load with add_resource_to_query(_name, path)
# 2) Start scenes load with start_load()
# 3) Get resources by name with get_resource(_name)

var resources_queue = []		# [ {"name": "name", "path": "path", "completed": false} ]
var loaded_resources = {}		# { "name": resource }

var threads = []

var loading_screen = null

func get_resource(_name: String):
	return loaded_resources.get(_name)

func add_resource_to_query(_name: String, path: String):
	resources_queue.append( {"name": _name, "path": path} )
	pass

func start_load():
	threads = []
	if not resources_queue.empty():
		loaded_resources = {}
		for res in resources_queue:
			var res_name = res["name"]
			var res_path = res["path"]
			var thread = LoadingThread.new()
			thread.resources_name = res_name
			thread.load_scene(res_path)
	pass

func add_loaded_resource(res_name: String, loaded_res):
	loaded_resources[res_name] = loaded_res

	if is_load_complete() and loading_screen:
		loading_screen._on_loading_ready()

func is_load_complete() -> bool:
	for res in resources_queue:
		var res_name = res["name"]

		# If at least one resource is not fully loaded, return false
		var r = loaded_resources.get(res_name)
		print("Res: ", r)
		if not res:
			return false

	return true

#var resources_queue = []		# [ {"name": "name", "path": "path", "completed": false} ]
#var loaded_resources = {}		# { "name": resource }
#
#var loading_screen = null
#
#var thread = null
#
#func add_resource_to_query(_name: String, path: String):
#	resources_queue.append( {"name": _name, "path": path} )
#	pass
#
#func start_load():
#	if not resources_queue.empty():
#		loaded_resources = {}
#		var path = resources_queue[0]["path"]
##		load_scene(path)
#	pass
#
#func get_resource(_name: String):
#	return loaded_resources[_name]

#func _thread_load(path):
#	print("Thread loading: ", path)
#	var ril = ResourceLoader.load_interactive(path)
#	assert(ril)
#
#	var res = null
#
#	while true: #iterate until we have a resource
#		# Poll (does a load step).
#		var err = ril.poll()
#		# If OK, then load another one. If EOF, it' s done. Otherwise there was an error.
#		if err == ERR_FILE_EOF:
#			# Loading done, fetch resource.
#			res = ril.get_resource()
#
#			# Storage fetched resource
#			var _name = resources_queue[0]["name"]
#			loaded_resources[_name] = res
#			print("Resource loaded: ", _name)
#
#			resources_queue.pop_front()
#
#				# Load next scene
#			if not resources_queue.empty():
##				thread.wait_to_finish()
#				load_scene( resources_queue[0]["path"] )
#				break
#		elif err != OK:
#			# Not OK, there was an error.
#			print("There was an error loading")
#			break
#
#	# Send whathever we did (or did not) get.
#	call_deferred("_thread_done", res)
#
#
#func _thread_done(resource):
#	print("Thread done: ", resource)
#	assert(resource)
#
#	# Always wait for threads to finish, this is required on Windows.
#	thread.wait_to_finish()
#
#	print(loaded_resources)
#	loading_screen._on_loading_ready()
#
#func load_scene(path):
#	print("Started loading: ", path)
#	thread = Thread.new()
#	thread.start( self, "_thread_load", path)
