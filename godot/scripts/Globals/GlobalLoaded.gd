extends Node

var load_queue = []		# [ {"name": "name", "path": "path"} ]

var loaded: Dictionary = {}

func _ready() -> void:
	pass

#func add_to_load_queue

func _request_load(_name: String, _path: String):
	if not _name in loaded.keys():
		loaded[_name] = load(_path)
	pass

func _is_fully_loaded() -> bool:
	for key in loaded.keys():
		print(loaded[key])
	return false
