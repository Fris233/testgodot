extends Area2D
var bullet = preload("res://bullet.tscn")

func _physics_process(delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range[0]
		look_at(target_enemy.global_position)
#		look_at(get_global_mouse_position()) #for cursor aiming

func shoot():
	var new_bullet = bullet.instantiate()
	new_bullet.global_position = %Bullleter.global_position
	new_bullet.global_rotation = %Bullleter.global_rotation
	%Bullleter.add_child(new_bullet)


func _on_timer_timeout() -> void:
	shoot()
