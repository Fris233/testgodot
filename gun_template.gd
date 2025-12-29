extends Area2D

@export_group("Gun Stats")
@export var fire_rate : float
@export var bulletscenes : Array[PackedScene]
@export var anglearray : Array[float]
@export var gun_sfx : AudioStream
@export var gun_chargeup : float 

var timer: Timer
var sound_player: AudioStreamPlayer

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
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	
	sound_player = AudioStreamPlayer.new()
	sound_player.stream = gun_sfx
	timer.add_child(sound_player)

func shoot():
	for i in range(bulletscenes.size()):
		var new_bullet = bulletscenes[i].instantiate()
		new_bullet.global_position = %Bullleter.global_position
		new_bullet.global_rotation = %Bullleter.global_rotation + deg_to_rad(anglearray[i])
		%Bullleter.add_child(new_bullet)


func _on_timer_timeout() -> void:
	sound_player.play()
	await get_tree().create_timer(gun_chargeup).timeout
	shoot()
