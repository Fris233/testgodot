extends CharacterBody2D

signal health_depleted

var health := 100.0
var speed := 600.0 # in pixels per second
var vuln := 5.0 # damage taken per enemy per second

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= vuln * overlapping_mobs.size() * delta
		$HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()
			
