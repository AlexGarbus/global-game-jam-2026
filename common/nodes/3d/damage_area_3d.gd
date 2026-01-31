@tool
class_name DamageArea3D
extends Area3D
## A region of 3D space that detects other [CollisionObject3D]s and applies damage to [Health].


## The [Health] node to apply damage to.
@export var health: Health: set = set_health
## The amount of damage to apply to [member health] when the attacking [CollisionObject3D] does not have damage defined.
@export var default_damage := 1


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray
	if not health:
		warnings.append("A Health node must be assigned.")
	return warnings


func set_health(value: Health) -> void:
	health = value
	update_configuration_warnings()


func _on_area_entered(area: Area3D) -> void:
	var attack_area := area as AttackArea3D
	if attack_area:
		health.current_value -= attack_area.damage
	else:
		health.current_value -= default_damage


func _on_body_entered(_body: Node3D) -> void:
	health.current_value -= default_damage
