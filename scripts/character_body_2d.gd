extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0

func _unhandled_input(event):
	if event.is_action_pressed("Interaction"):
		DialogueManager.skip_or_hide()
		
		
func _ready() -> void:
	Main.connect("day1Begin", Callable(self, "on_day1begin"))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	

	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("Move_left", "Move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
	
	#beginning of day!
	
func on_day1begin():
	await TaskManager.hasInteractedwithPerson == true
	DialogueManager.show_caption("Hey, myself ....")
		
