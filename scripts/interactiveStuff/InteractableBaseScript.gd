extends Area2D

@export var description: String = ""
signal interacted(message)

var player_is_near = false

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		show_description()

func _process(delta: float) -> void:
	if player_is_near and Input.is_action_just_pressed("Interaction"):
		show_description()
#
#func show_description():
	#emit_signal("interacted", description)
	#print(description)

func show_description():
	# Find the caption system and show the text
	#get_tree().get_first_node_in_group("caption_ui").show_caption(description)
	DialogueManager.show_caption(description)
	
	
	


func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		player_is_near = true


func _on_body_exited(body: Node2D):
	if body.is_in_group("player"):
		player_is_near = false
