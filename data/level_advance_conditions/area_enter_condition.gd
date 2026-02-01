class_name AreaEnterCondition
extends LevelAdvanceCondition


@export var area_path: NodePath


func initialize(level: LevelScene) -> void:
	var area := level.get_node(area_path) as Area3D
	if not area:
		push_error("AreaEnterCondition requires Area3D!")
	area.body_entered.connect(_on_body_entered)


func _on_body_entered(body: PhysicsBody3D) -> void:
	fulfilled.emit()
