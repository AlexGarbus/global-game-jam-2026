class_name LevelScene
extends MainScene


@export var advance_condition: LevelAdvanceCondition


func _ready() -> void:
	advance_condition.initialize(self)
	advance_condition.fulfilled.connect(_on_advance_condition_fulfilled)


func _on_advance_condition_fulfilled() -> void:
	finished.emit(true)


func _on_game_over_animation_finished() -> void:
	finished.emit(false)
