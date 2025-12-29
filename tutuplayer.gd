extends CharacterBody2D

signal health_depleted

var health := 100.0
var speed := 600.0 # in pixels per second
var vuln := 5.0 # damage taken per enemy per second

@onready var guns = [
	$mattgun,
	$purplegun,
	$gun,
	$gun67
]
@onready var joystick = $UI_Layer/VirtualJoystick

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# 2. Check Joystick Input (if joystick is being used, it overrides keyboard)
	if joystick and joystick.output != Vector2.ZERO:
		direction = joystick.output
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
			

@onready var choice_menu = $UI_Layer/ChoiceMenu
@onready var timer = $SelectionTimer

func _ready():
	choose_gun(2)
	choice_menu.visible = false
	if OS.has_feature("pc"):
		joystick.queue_free()
	
	# Connect the UI buttons
	# You can also do this via the Editor's Node tab
	$UI_Layer/ChoiceMenu/Button1.pressed.connect(_on_button_1_pressed)
	$UI_Layer/ChoiceMenu/Button2.pressed.connect(_on_button_2_pressed)
	$UI_Layer/ChoiceMenu/Button3.pressed.connect(_on_button_3_pressed)
	$UI_Layer/ChoiceMenu/Button4.pressed.connect(_on_button_4_pressed)
	# Connect the 30s timer
	timer.timeout.connect(_on_selection_timer_timeout)

func _on_selection_timer_timeout():
	# 1. Pause the game (Stops movement, enemies, and shooting)
	get_tree().paused = true
	# 3. Show the menu
	choice_menu.visible = true

func choose_gun(index: int):
	# Option A: SWITCH (Only 1 active at a time)
	# Disable all guns first
	for gun in guns:
		gun.process_mode = Node.PROCESS_MODE_DISABLED
		gun.visible = false
		
	# Enable the chosen one
	guns[index].process_mode = Node.PROCESS_MODE_INHERIT
	guns[index].visible = true

	# Option B: ADD (Unlock another gun simultaneously)
	# If you want them all shooting at once, just enable the specific index:
	# guns[index].process_mode = Node.PROCESS_MODE_INHERIT
	# guns[index].visible = true

	_close_menu()

func _close_menu():
	choice_menu.visible = false
	get_tree().paused = false


func _on_button_1_pressed():
	choose_gun(0)

func _on_button_2_pressed():
	choose_gun(1)

func _on_button_3_pressed():
	choose_gun(2)
	
func _on_button_4_pressed():
	choose_gun(3)

func _enter_tree():
	# As soon as the player enters the world, force the camera to take over.
	# Make sure the node name matches exactly.
	if has_node("Camera2D"):
		$Camera2D.make_current()
