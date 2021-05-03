extends KinematicBody2D
class_name Enemy

onready var timer = get_node("Timer")
onready var animation_player = get_node("AnimationPlayer")

export var speed : = 250.0
export var seek_delay : int = 2
export var position_list: PoolVector2Array
export var vision_range = 100
export var is_enabled = true
var path : = PoolVector2Array() setget set_path
var next_patrol_position : = self.transform.origin
var last_seen = null
var seek = false
var i : int = 0
var last_axis = Vector2(1,0)
var patrol: bool = false

func _ready() -> void:
	pass
#	position_list.append(Vector2(-299,400))
#	position_list.append(Vector2(-299,-37))
#	position_list.append(Vector2(-77,199))


func _physics_process(delta: float) -> void:
	if is_enabled:
		if LevelManager.current_level:
			var move_distance = speed * delta
			move_along_path(move_distance)
			light_detect()
			patrol()

			if self.transform.origin == last_seen:
				if seek == false:
		#			print("ainnn entro")
					timer.wait_time = seek_delay
					seek = true
					timer.start()
		else:
			if not animation_player.is_playing():
				animation_player.play("walk_foward")


func set_enabled(state: bool):
	is_enabled = state

func is_enabled():
	return is_enabled()

func add_patrol_destination(destination: Vector2):
	position_list.append(destination)

func insert_patrol_destination(index: int, destination: Vector2):
	position_list.insert(index, destination)

func move_along_path(distance : float) -> void:
	var last_point : = position
	for index in range(path.size()):
		var distance_to_next = last_point.distance_to(path[0])
		animation(path[0] - last_point) # animation
		if distance <= distance_to_next and distance >= 0.0:
			position = last_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif path.size() == 1 and distance >= distance_to_next:
			position = path[0]
			set_process(false)
			break

		distance -= distance_to_next
		last_point = path[0]
		path.remove(0)


func set_path(value : PoolVector2Array) -> void:
	if value.size() == 0:
		return
	path = value
	path.remove(0)
	set_process(true)

func go_in_a_place(where) -> void:
	var new_path = LevelManager.nav_2d.get_simple_path(
		self.transform.origin,
		where
	)
	path = new_path

func _on_Timer_timeout() -> void:
	speed = 150.0
#	print("entrei ainnnn")
	go_in_a_place(next_patrol_position)
	seek = false;

func is_light_source_on_range(light_source: LightSource):
	var distance = self.transform.origin.distance_to(LevelManager.player.transform.origin)

	vision_range = light_source.get_radius()

	var comparison = distance <= vision_range and light_source.is_enabled
	#print("Distance: ", distance, " | Comparison: ", comparison)
	return comparison

func light_detect() -> void:
	if is_light_source_on_range(LevelManager.player.light_source) && LevelManager._playerLife > 0:
		speed = 250.0
		go_in_a_place(LevelManager.player.transform.origin)
		patrol = false
	elif patrol == false:
		timer.wait_time = seek_delay
		timer.start()
		patrol = true

func patrol() -> void:
	if patrol == true && next_patrol_position == self.transform.origin:
		speed = 100.0
		i = (i + 1) % position_list.size()
		next_patrol_position = position_list[i]
		go_in_a_place(next_patrol_position)


func animation(axis) -> void:
	var next_animation
	if axis.x == 0 && axis.y == 0:
		if last_axis.x == 0 && last_axis.y > 0:
			next_animation = "enemy_idle_backward"
		elif last_axis.x == 0 && last_axis.y < 0:
			next_animation = "enemy_idle_foward"
		elif last_axis.x > 0 && last_axis.y == 0:
			next_animation = "enemy_idle_right"
		elif last_axis.x < 0 && last_axis.y == 0:
			next_animation = "enemy_idle_left"
		elif last_axis.x > 0 && last_axis.y > 0:
			next_animation = "enemy_idle_backward_right"
		elif last_axis.x < 0 && last_axis.y > 0:
			next_animation = "enemy_idle_backward_left"
		elif last_axis.x > 0 && last_axis.y < 0:
			next_animation = "enemy_idle_foward_right"
		elif last_axis.x < 0 && last_axis.y < 0:
			next_animation = "enemy_idle_foward_left"
	else:
		if axis.x == 0 && axis.y > 0:
			next_animation = "enemy_walk_backward"
		elif axis.x == 0 && axis.y < 0:
			next_animation = "enemywalk_foward"
		elif axis.x > 0 && axis.y == 0:
			next_animation = "enmy_walk_right"
		elif axis.x < 0 && axis.y == 0:
			next_animation = "enemy_walk_left"
		elif axis.x > 0 && axis.y > 0:
			next_animation = "enemy_walk_backward_right"
		elif axis.x < 0 && axis.y > 0:
			next_animation = "enemy_walk_backward_left"
		elif axis.x > 0 && axis.y < 0:
			next_animation = "enemy_walk_foward_right"
		elif axis.x < 0 && axis.y < 0:
			next_animation = "enemy_walk_foward_left"
	last_axis = axis
#	if next_animation != animation_player.current_animation:
#		animation_player.play(next_animation)
#		print(animation_player.current_animation)
