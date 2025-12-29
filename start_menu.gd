extends Control

const gameroot = preload("res://tutugame.tscn")



func _on_start_button_pressed() -> void:
	get_parent().add_child(gameroot.instantiate())
	queue_free()
