class_name PickupArea
extends Area3D


@export var effects: Array[PickupEffect]


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(_area: Area3D) -> void:
	queue_free()
