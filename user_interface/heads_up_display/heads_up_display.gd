extends Control


const HealthBar := preload("uid://cffrarbeuph2t")
const Player := preload("uid://covk2281f0gro")

@export var _player: Player

@onready var _player_health_bar: HealthBar = $PlayerHealthBar


func _ready() -> void:
	await get_tree().process_frame
	_player_health_bar.health = _player.health
