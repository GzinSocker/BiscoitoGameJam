extends "res://src/Actors/Actor.gd"

var _last_nonzero_direction: = Vector2(1, 0)
onready var player_anim: = $AnimatedSprite

func _physics_process(delta: float) -> void:
	move()
	
func move() -> void:
	var direction: = calculate_direction()
	_velocity = calculate_velocity(_velocity, direction)
	
	# animation
	player_anim.flip_h = _last_nonzero_direction.x < 0
	
	if Input.is_action_just_pressed("jump"):
		player_anim.play("jump")
	elif !is_on_floor():
		if _velocity.y >= 0:
			player_anim.play("fall")
		else:
			player_anim.play("on_air")
	elif _velocity.x == 0:
		player_anim.play("hold")
	else:
		player_anim.play("run")
	
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
func calculate_direction() -> Vector2:
	var direction: = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1 if Input.is_action_pressed("jump") and is_on_floor() else 0
	)
	
	if direction.x != 0:
		_last_nonzero_direction = direction
		
	return direction

func calculate_velocity(linear_velocity: Vector2, direction: Vector2) -> Vector2:
	var new_vel: = linear_velocity
	new_vel.x = speed.x * direction.x
	new_vel.y += gravity * get_physics_process_delta_time()
	
	if direction.y == -1:
		new_vel.y = speed.y * direction.y
		
	return new_vel
