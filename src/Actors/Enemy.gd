extends "res://src/Actors/Actor.gd"

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
