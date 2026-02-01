extends Node


const Player := preload("uid://covk2281f0gro")

@export var _player: Player


func _on_boss_battling_changed(value: bool) -> void:
	if not value and not _player.input_disabled:
		_player.process_mode = Node.PROCESS_MODE_DISABLED
	_player.input_disabled = not value
