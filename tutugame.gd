extends Node2D

@onready var gameover = %gameover

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%Spawner.progress_ratio = randf()
	new_mob.global_position = %Spawner.global_position
	add_child(new_mob)

func _on_spawn_timer_timeout() -> void:
	spawn_mob()


func _on_have_sex_health_depleted() -> void:
	%"Game Over".visible = true
	gameover.process_mode = Node.PROCESS_MODE_ALWAYS
	gameover.play()
	get_tree().paused = true
