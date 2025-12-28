extends Control

# Output vector accessible by the player
var output = Vector2.ZERO

@onready var base = $Base
@onready var knob = $Base/Knob

# Maximum distance the knob can move (Radius of the base)
# Adjust this based on your image size (e.g., 64 if image is 128px wide)
var max_distance = 40 

func _gui_input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if event is InputEventScreenTouch and not event.pressed:
			reset_joystick()
		else:
			# Calculate the position relative to the center of the base
			var target_position = event.position - base.position - (base.size / 2)
			
			# Limit the length so the knob stays inside the circle
			if target_position.length() > max_distance:
				target_position = target_position.normalized() * max_distance
			
			# Move the visual knob
			knob.position = target_position + (base.size / 2) - (knob.size / 2)
			
			# Calculate the output vector (0 to 1)
			output = target_position / max_distance

func reset_joystick():
	output = Vector2.ZERO
	# Reset knob to the center of the base
	knob.position = (base.size / 2) - (knob.size / 2)
