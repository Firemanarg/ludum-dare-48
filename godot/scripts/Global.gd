extends Node

var nav_2d : Navigation2D = null
var Enemy : KinematicBody2D = null
var player : KinematicBody2D = null
var _playerLife : int = 0

var light_sources = []

func map(value, low1, high1, low2, high2):
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1)
