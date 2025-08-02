extends CanvasLayer

@onready var label = $MarginContainer/Panel/Label

signal caption_done

var is_displaying := false
var full_text := ""
var letter_index := 0
var char_interval := 0.03
var reveal_timer: SceneTreeTimer = null
var is_waiting_for_input := false

func _process(_delta):
	if is_waiting_for_input and Input.is_action_just_pressed("Interaction"):
		hide()
		is_displaying = false
		is_waiting_for_input = false
		emit_signal("caption_done")

func _reveal_next_char():
	if letter_index < full_text.length():
		label.text += full_text[letter_index]
		letter_index += 1
		reveal_timer = get_tree().create_timer(char_interval)
		reveal_timer.timeout.connect(_reveal_next_char)
	else:
		# Done revealing
		is_displaying = true
		is_waiting_for_input = true

func skip_or_hide():
	if is_displaying and letter_index >= full_text.length():
		# Already fully shown — just let _process() handle hiding
		pass
	else:
		# Instantly finish text
		label.text = full_text
		letter_index = full_text.length()

# ✅ This is now async and await-able
func show_caption(text: String) -> void:
	# If already showing something and not done, instantly finish it
	if is_displaying and letter_index < full_text.length():
		label.text = full_text
		letter_index = full_text.length()
		return

	# Start a new caption
	full_text = text
	label.text = ""
	letter_index = 0
	is_displaying = true
	show()

	reveal_timer = get_tree().create_timer(char_interval)
	reveal_timer.timeout.connect(_reveal_next_char)

	await self.caption_done  # ✅ This makes await DialogueManager.show_caption(...) work
