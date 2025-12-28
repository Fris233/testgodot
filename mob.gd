extends CharacterBody2D

var health := 5

@onready var player = get_node("/root/Game/HaveSex")
@onready var speed : float = player.speed /2

const deathanim = preload("res://smoke_explosion/smoke_explosion.tscn")
const deathsound = preload("res://sounds/slimed.tscn")

func _ready():
	%Slime.play_walk()

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

func take_damage(damage):
	$Slime.play_hurt()
	health -= damage
	if health <= 0:
		death()

func death():
	queue_free()
	var death := deathanim.instantiate()
	var deathsound := deathsound.instantiate()
	get_parent().add_child(death)
	get_parent().add_child(deathsound)
	death.global_position = global_position
	deathsound.global_position = global_position
	deathsound.play()
