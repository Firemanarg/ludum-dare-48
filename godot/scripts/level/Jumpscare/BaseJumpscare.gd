extends Control
class_name BaseJumpscare


onready var timer_initial_delay = get_node("TimerInitialDelay")
onready var timer_duration = get_node("TimerDuration")
onready var audio_player = get_node("AudioStreamPlayer")
onready var animation_player = get_node("AnimationPlayer")
onready var image = get_node("EnemyImage")
onready var fade = get_node("Fade")


export(float) var initial_delay = 0.2
export(float) var ending_delay = 0.2
export(float) var duration = 1.0
var enemy = null

func _ready() -> void:
	image.visible = false
	pass

func show():
	LevelManager.jumpscare_in_progress = true
	LevelManager.pause_game()
	fade.fade_out(initial_delay)
	timer_initial_delay.start()
	pass

func show_action():
	image.visible = true
	if not animation_player.is_playing():
		animation_player.play("jumpscare_show")
	if not audio_player.playing:
		audio_player.play()

func hide():
	LevelManager.unpause_game()
	LevelManager.jumpscare_in_progress = false
	self.queue_free()
	pass

func keep_on_screen():
	animation_player.stop()
	animation_player.play("jumpscare_keep_on_screen")
	pass

func _on_TimerInitialDelay_timeout() -> void:
	show_action()
	timer_duration.start()
	pass


func _on_TimerDuration_timeout() -> void:
	fade.connect("fade_completed", self, "hide")
	fade.fade_in(ending_delay)
	pass


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "jumpscare_show":
		keep_on_screen()
	pass
