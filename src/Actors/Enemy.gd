extends "res://src/Actors/Actor.gd"

const speed: Vector2 = Vector2(350, 400)

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)


func _on_HitArea_area_entered(area):
	$AnimatedSprite.play("hurt")


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "hurt":
		queue_free()
