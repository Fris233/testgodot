extends Area2D
var bullet6 := preload("res://six_bullet.tscn")
var bullet7 := preload("res://sevenbul.tscn")
var equipped := true

var bulls := {bullet6: -20, bullet7: 20}


func _physics_process(delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range[0]
		look_at(target_enemy.global_position)
#		look_at(get_global_mouse_position()) #for cursor aiming

func shoot():
	for bull in bulls:
		var new_bullet = bull.instantiate()
		new_bullet.global_position = %Bullleter.global_position
		new_bullet.global_rotation = %Bullleter.global_rotation + deg_to_rad(bulls[bull])
		%Bullleter.add_child(new_bullet)



func _on_timer_timeout() -> void:
	%gunsound.play()
	shoot()
