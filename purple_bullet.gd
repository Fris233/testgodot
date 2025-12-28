extends Area2D

var bulletsped := 500.0
var travelledDist := 0
var rangebuff := 200.0 
var range := bulletsped + rangebuff
var damage := 5

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * bulletsped * delta
	
	travelledDist += bulletsped * delta
	if travelledDist > range:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
#	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(damage)
