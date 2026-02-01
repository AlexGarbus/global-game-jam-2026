class_name BossDefeatCondition
extends LevelAdvanceCondition


const Boss := preload("uid://dx6nmxubl7ca4")

@export var boss_path: NodePath


func initialize(level: LevelScene) -> void:
	var boss := level.get_node(boss_path) as Boss
	if not boss:
		push_error("BossDefeatCondition requires Boss!")
	boss.defeated.connect(_on_boss_defeated)


func _on_boss_defeated() -> void:
	fulfilled.emit()
