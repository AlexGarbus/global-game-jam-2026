extends Node3D


signal battling_changed(value: bool)
signal defeated

const Player := preload("uid://covk2281f0gro")

@export var _player: Player

var battling := false: set = set_battling

@onready var _anim: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	if not battling:
		return
	look_at(_player.global_position)


func set_battling(value: bool) -> void:
	battling = value
	battling_changed.emit(value)


func defeat() -> void:
	defeated.emit()


func _on_health_reached_zero() -> void:
	_anim.play("defeat")
