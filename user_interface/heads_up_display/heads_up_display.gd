extends Control


const HealthBar := preload("uid://cffrarbeuph2t")
const Player := preload("uid://covk2281f0gro")

@export var _player: Player
@export_category("Messages")
@export var _start_message: Message
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var _message_fade_time := 1.0

@onready var _canvas_modulate: CanvasModulate = %CanvasModulate
@onready var _message_label: Label = %MessageLabel
@onready var _message_timer: Timer = $MessageTimer
@onready var _player_health_bar: HealthBar = $PlayerHealthBar


func _ready() -> void:
	if _start_message:
		show_message(_start_message)
	else:
		_message_label.visible = false
	await get_tree().process_frame
	_player_health_bar.health = _player.health


func show_message(message: Message) -> void:
	_message_label.text = message.text
	_message_timer.start()


func _on_message_timer_timeout() -> void:
	_canvas_modulate.color = Color.WHITE
	var tween := create_tween()
	tween.tween_property(_canvas_modulate, "color", Color(1, 1, 1, 0), _message_fade_time)
	tween.tween_callback(_message_label.hide)
