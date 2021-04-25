extends KinematicBody2D

var speed : = 250.0
var path : = PoolVector2Array() setget set_path
var starting_position : = self.transform.origin
onready var timer = get_node("Timer")
export var seek_delay : int = 2
var last_seen = null
var seek = false
var timeout = false

func _ready() -> void:
	pass

#func _unhandled_input(event: InputEvent) -> void:
#	if not event is InputEventMouseButton:
#		return
#	if event.button_index != BUTTON_LEFT or not event.pressed:
#		return
#	speed = 250.0
#	go_in_a_place(Global.player.transform.origin)
#	last_seen = Global.player.transform.origin


func _physics_process(delta: float) -> void:
	var move_distance = speed * delta
	move_along_path(move_distance)
	near_attack()
	
#	print(timer.time_left)
	# I need to fix the code bellow and make a func, this timer only works one time ************
#	if self.transform.origin == last_seen:
#		if seek == false:
#			timer.wait_time = seek_delay
#			seek = true
#			timeout = false
#			timer.start()
#		else:
#			if timeout == true:
#				timer.stop()
#				seek == false

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
	timeout = true
	speed = 150.0
	go_in_a_place(starting_position)

func near_attack() -> void:
	if self.transform.origin.distance_to(Global.player.transform.origin) < 800 && Global._playerLife > 0:
		speed = 250.0
		go_in_a_place(Global.player.transform.origin)


func _on_Area2D_body_entered(body: Node) -> void:
	print("asdyhvasdguaysdb     " + body.name)
	if not body == self.get_node("Area2D"):
		Global._playerLife -= 1
		if(Global._playerLife <= 0):
			print("You died !!!")
