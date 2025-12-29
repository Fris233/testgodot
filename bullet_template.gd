extends Area2D

@export_group("Bullet Stats")
@export var bulletsped : float
@export var rangebuff : float 
@export var damage : int
@export var max_piercing : int

var cur_pierce := 0
@onready var range : float = bulletsped + rangebuff
var travelledDist : float = 0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * bulletsped * delta
	travelledDist += bulletsped * delta
	if travelledDist >= range:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	cur_pierce +=1
	if cur_pierce > max_piercing:
		queue_free()
	if body.has_method("take_damage"):
		body.take_damage(damage)
