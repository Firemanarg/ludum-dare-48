extends KinematicBody2D

var speed : = 250.0
var path : = PoolVector2Array() setget set_path
var next_patrol_position : = self.transform.origin
onready var timer = get_node("Timer")
export var seek_delay : int = 2
var last_seen = null
var seek = false
var position_list: PoolVector2Array
var i : int = 0
var patrol: bool = false

func _ready() -> void:
	position_list.append(Vector2(-299,400))
	position_list.append(Vector2(-299,-37))
	position_list.append(Vector2(-77,199))

func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	if event.button_index != BUTTON_LEFT or not event.pressed:
		return
	speed = 250.0
	last_seen = Global.player.transform.origin
	go_in_a_place(last_seen)


func _physics_process(delta: float) -> void:
	var move_distance = speed * delta
	move_along_path(move_distance)
	light_detect()
	patrol()

	if self.transform.origin == last_seen:
		if seek == false:
			print("ainnn entro")
			timer.wait_time = seek_delay
			seek = true
			timer.start()


func move_along_path(distance : float) -> void:
	var last_point : = position
	for index in range(path.size()):
		var distance_to_next = last_point.distance_to(path[0])
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
	var new_path : = Global.nav_2d.get_simple_path(
		self.transform.origin,
		where
	)
	path = new_path

func _on_Timer_timeout() -> void:
	speed = 150.0
#	print("entrei ainnnn")
	go_in_a_place(next_patrol_position)
	seek = false;

func light_detect() -> void:
	if self.transform.origin.distance_to(Global.player.transform.origin) < 200 && Global._playerLife > 0:
		speed = 250.0
		go_in_a_place(Global.player.transform.origin)
		patrol = false
	elif patrol == false:
		timer.wait_time = seek_delay
		timer.start()
		patrol = true


func _on_Area2D_body_entered(body: Node) -> void:
	print("asdyhvasdguaysdb     " + body.name)
	if not body == self.get_node("Area2D"):
		Global._playerLife -= 1
		if(Global._playerLife <= 0):
			print("You died !!!")

func patrol() -> void:
	if patrol == true && next_patrol_position == self.transform.origin:
		speed = 100.0
		i = (i + 1) % position_list.size()
		next_patrol_position = position_list[i]
		go_in_a_place(next_patrol_position)

