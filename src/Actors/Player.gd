extends "res://src/Actors/Actor.gd"

var _last_nonzero_direction: = Vector2(1, 0)

func _physics_process(delta: float) -> void:
	move()
	
func move() -> void:
	var direction: = calculate_direction()
	_velocity.x = speed.x * direction.x
	_velocity.y += gravity * get_physics_process_delta_time()
	
	if direction.y == -1:
		_velocity.y = speed.y * direction.y
		
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
func calculate_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1 if Input.is_action_pressed("jump") and is_on_floor() else 0
	)
