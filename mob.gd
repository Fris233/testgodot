extends CharacterBody2D

var health := 3

@onready var player = get_node("/root/Game/HaveSex")
@onready var speed : float = player.speed /2

const deathanim = preload("res://smoke_explosion/smoke_explosion.tscn")
@onready var deathsound = %slimed

func _ready():
	%Slime.play_walk()

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

func take_damage():
	$Slime.play_hurt()
	health -= 1
	if health == 0:
		death()

func death():
	%slimed.process_mode = Node.PROCESS_MODE_ALWAYS
	%slimed.play
	queue_free()
	var death := deathanim.instantiate()
	get_parent().add_child(death)
	death.global_position = global_position
	
