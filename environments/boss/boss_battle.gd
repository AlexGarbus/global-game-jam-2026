extends Node


const Player := preload("uid://covk2281f0gro")

@export var _player: Player


func _on_boss_battling_changed(value: bool) -> void:
	if value:
		_player.input_disabled = false
	else:
		_player.process_mode = Node.PROCESS_MODE_DISABLED
