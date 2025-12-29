extends Area2D
var bullet := preload("res://mattbullet.tscn")
var bullet2 := preload("res://mattbullet_2.tscn")
var bullet3 := preload("res://mattbullet_3.tscn")
var equipped := true

var bullets := {bullet: -30, bullet2: 0, bullet3: 30}

func _physics_process(delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range[0]
		look_at(target_enemy.global_position)
#		look_at(get_global_mouse_position()) #for cursor aiming

func shoot():
	for bullet in bullets:
		var new_bullet = bullet.instantiate()
		new_bullet.global_position = %Bullleter.global_position
		new_bullet.global_rotation = %Bullleter.global_rotation + deg_to_rad(bullets[bullet])
		%Bullleter.add_child(new_bullet)



func _on_timer_timeout() -> void:
	%gunsound.play()
	shoot()
