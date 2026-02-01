extends Control


const HealthBar := preload("uid://cffrarbeuph2t")
const Player := preload("uid://covk2281f0gro")

@export var _player: Player
@export_group("Messages")
@export var _start_message: Message
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var _message_show_time := 4.0 
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var _message_fade_time := 1.0

var _message_tween: Tween

@onready var _canvas_modulate: CanvasModulate = %CanvasModulate
@onready var _message_label: Label = %MessageLabel
@onready var _player_health_bar: HealthBar = $PlayerHealthBar


func _ready() -> void:
	if _start_message:
		show_message(_start_message)
	else:
		_message_label.visible = false
	MessageBus.received.connect(_on_message_bus_received)
	await get_tree().process_frame
	_player_health_bar.health = _player.health


func show_message(message: Message) -> void:
	_message_label.show()
	_message_label.text = message.text
	_canvas_modulate.color = Color.WHITE
	var tween := create_tween()
	tween.tween_interval(_message_show_time)
	tween.tween_property(_canvas_modulate, "color", Color(1, 1, 1, 0), _message_fade_time)
	tween.tween_callback(_message_label.hide)
	_message_tween = tween


func _on_message_bus_received(message: Message) -> void:
	if not _message_tween.is_running():
		show_message(message)
