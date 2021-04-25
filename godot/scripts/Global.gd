extends Node

var nav_2d : Navigation2D = null
var Enemy : KinematicBody2D = null
var player : KinematicBody2D = null
var _plaayerLife : int = 1

func map(value, low1, high1, low2, high2):
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1)
