extends Node


signal received(message: Message)


func send(message: Message) -> void:
	received.emit(message)
