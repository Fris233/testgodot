extends Control



var gameSend
var parent

func setroot(game):
	gameSend = game
	parent = game.get_parent()
	gameSend.get_tree().paused = true


func _on_unpause_pressed() -> void:
	get_tree().paused = false
	queue_free()


func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	queue_free()



func _on_goto_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://start_menu.tscn")
	queue_free()


func _on_exit_pressed() -> void:
	get_tree().quit()

#
