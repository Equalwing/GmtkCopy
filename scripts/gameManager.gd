extends Node2D

signal day1Begin


var current_day = 1
var day1Dialogues = [
	"Narrator: day1",
	"Hmm, what a place this is. Gotta clean it all",
	"I guess i should go talk to him"
]

func _ready() -> void:
	TimeController.is_paused = true
	if current_day == 1:
		day1()

	
	
func day1():
	#start of day 1.. begin with cutscene
	timeForCutscene(1)
	TimeController.current_time = 0.4
	
	await DialogueManager.show_caption(day1Dialogues[0])
	await DialogueManager.show_caption(day1Dialogues[1])
	await DialogueManager.show_caption(day1Dialogues[2])
	emit_signal("day1Begin")
	
	

func timeForCutscene(time):
	await get_tree().create_timer(time)
	
	
