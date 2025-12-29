extends Area2D

@export_group("Stats")
@export var fire_rate := 0.5
@export var bulletscenes : Array[PackedScene]
@export var anglearray : Array[float]

var timer: Timer

func _physics_process(delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range[0]
		look_at(target_enemy.global_position)
#		look_at(get_global_mouse_position()) #for cursor aiming

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = fire_rate
	timer.autostart = true
	timer.timout.connect(_on_timer_timeout)
	add_child(timer)

func shoot():
	for i in range(bulletscenes.size()):
		var new_bullet = bulletscenes[i].instantiate()
		new_bullet.global_position = %Bullleter.global_position
		new_bullet.global_rotation = %Bullleter.global_rotation + deg_to_rad(anglearray[i])
		%Bullleter.add_child(new_bullet)


func _on_timer_timeout() -> void:
	%gunsound.play()
	shoot()
