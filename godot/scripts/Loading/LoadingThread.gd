extends Node
class_name LoadingThread

var thread = null

var resources_name = ""
#var loaded_resources = null

func _ready():
	pass


func _thread_load(path):
	print("Thread loading: ", path)
	var ril = ResourceLoader.load_interactive(path)
	assert(ril)

	var res = null

	while true: #iterate until we have a resource
		# Poll (does a load step).
		var err = ril.poll()
		# If OK, then load another one. If EOF, it' s done. Otherwise there was an error.
		if err == ERR_FILE_EOF:
			# Loading done, fetch resource.
			res = ril.get_resource()
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

#	print(loaded_resources)

	# Save fetched resource
	GlobalLoaded.add_loaded_resource(resources_name, resource)
#	GlobalLoaded.loaded_resources[resources_name] = resource
#	loaded_resources = resource

func load_scene(path):
	print("Started loading: ", path)
	thread = Thread.new()
	thread.start( self, "_thread_load", path)
