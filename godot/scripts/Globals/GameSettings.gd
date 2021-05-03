extends Node

var sound_level = 0.5
var music_level = 0.5

var max_music_volume_db = 24
var min_music_volume_db = -80
var max_sound_volume_db = 24
var min_sound_volume_db = -80

func _ready() -> void:
	self.pause_mode = Node.PAUSE_MODE_PROCESS
	pass

func get_sound_level():
	return sound_level

func get_sound_volume():
	if sound_level == 0.0:
		return -500
	else:
		return GlobalFunctions.map(
			sound_level,
			0.0, 1.0,
			min_sound_volume_db,
			max_sound_volume_db
		)

func set_sound_level(level: float):
	level = clamp(level, 0.0, 1.0)
	sound_level = level
	LevelManager.current_level.adjust_audio_levels()

func get_music_level():
	return music_level

func get_music_volume():
	if music_level == 0.0:
		return -500
	else:
		return GlobalFunctions.map(
			music_level,
			0.0, 1.0,
			min_music_volume_db,
			max_music_volume_db
		)

func set_music_level(level: float):
	level = clamp(level, 0.0, 1.0)
	music_level = level
	LevelManager.current_level.adjust_audio_levels()
