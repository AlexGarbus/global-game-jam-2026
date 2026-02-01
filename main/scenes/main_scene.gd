class_name MainScene
extends Node


signal finished(advance: bool)


func finish(advance: bool) -> void:
	finished.emit(advance)
