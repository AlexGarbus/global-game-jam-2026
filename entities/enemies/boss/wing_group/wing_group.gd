extends Node3D


const Eye := preload("uid://5vhu0fombpnq")

@export var _wings: Array[Node3D]

var _eyes: Array[Eye]


func _ready() -> void:
	for wing in _wings:
		for child in wing.get_children():
			var eye := child as Eye
			if eye:
				_eyes.append(eye)


func set_active(value: bool) -> void:
	for eye in _eyes:
		eye.set_shooting(value)
