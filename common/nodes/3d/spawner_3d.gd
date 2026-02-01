class_name Spawner3D
extends Node3D
## A node that spawns scenes in 3D space.


signal spawned

## How [member scene] will be spawned relative to the node at [member spawn_path].
enum SPAWN_MODE {
	## Spawn [member scene] as a sibling of the node at [member spawn_path].
	SIBLING,
	## Spawn [member scene] as a child of the node at [member spawn_path].
	CHILD
}

## The serialized scene to spawn.
@export var scene: PackedScene
## The relative path that [member scene] will be spawned at.
@export var spawn_path: NodePath
@export var spawn_mode: SPAWN_MODE
## Whether spawned instances should inherit their parents' transforms.
@export var spawn_top_level := false

func spawn() -> void:
	var instance := scene.instantiate()
	var instance_3d := instance as Node3D
	if instance_3d:
		instance_3d.global_transform = global_transform
		instance_3d.top_level = spawn_top_level
	var node := get_node(spawn_path)
	if spawn_mode == SPAWN_MODE.SIBLING:
		node.add_sibling(instance)
	elif spawn_mode == SPAWN_MODE.CHILD:
		node.add_child(instance)
	spawned.emit()
