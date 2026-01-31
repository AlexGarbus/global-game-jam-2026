class_name Inventory
extends Node


signal gem_changed(type: Enum.GemType, value: bool)
signal all_gems_collected()

@export var _start_with_gems := false

var _gems: Array[bool]


func _ready() -> void:
	_gems.resize(Enum.GemType.keys().size())
	_gems.fill(_start_with_gems)


func has_gem(type: Enum.GemType) -> bool:
	return _gems[type]


func set_gem(type: Enum.GemType, value: bool) -> void:
	_gems[type] = value
	gem_changed.emit(type, value)
	if not _gems.has(false):
		all_gems_collected.emit()
