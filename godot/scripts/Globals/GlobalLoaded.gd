extends Node

var load_queue = []		# [ {"name": "name", "path": "path"} ]

var loaded: Dictionary = {}

var load_in_progress = false

func _ready() -> void:
	pass

func add_to_load_queue(_name: String, _path: String):
	if not load_in_progress:
		load_queue.append( {"name": _name, "path": _path} )

func start_load():
	pass

func _is_fully_loaded() -> bool:
	for key in loaded.keys():
		print(loaded[key])
	return false
