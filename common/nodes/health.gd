class_name Health
extends Node
## A node that stores health information for an entity.


## Emitted when the current health value has changed.
signal changed(old_value: int, new_value: int)
## Emitted when the current health value reaches zero.
signal reached_zero()

## The maximum value that the health may increase to.
@export_range(1, 100, 1, "or_greater") var max_value := 1: set = set_max_value

## The current health value. Automatically clamped between 0 and [member max_value].
var current_value: int: set = set_current_value


func _ready() -> void:
	current_value = max_value


func set_max_value(value: int) -> void:
	max_value = value
	current_value = min(current_value, max_value)


func set_current_value(value: int) -> void:
	var old_value = current_value
	current_value = clampi(value, 0, max_value)
	changed.emit(old_value, current_value)
	if current_value == 0:
		reached_zero.emit()


## Returns [member current_value] as a ratio between 0.0 and 1.0.
func get_ratio() -> float:
	return float(current_value) / max_value
