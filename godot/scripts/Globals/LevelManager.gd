extends Node

var nav_2d : Navigation2D = null
var Enemy : Enemy = null
var player : Player = null
var _playerLife : int = 0
var picked_up_the_key = false

var enemies : Array = []
var light_sources: Array = []
var current_level = null

func map(value, low1, high1, low2, high2):
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1)
