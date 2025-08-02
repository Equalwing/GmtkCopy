extends Node
 #THese are the signals defined - other scripts can connect to these signals and respond
signal time_updated(current_time)
signal day_started
signal night_started
signal day_ended

var current_time := 0.0
var time_speed := 10
var is_paused := false

var transition_thresholds = {
	"morning": 0.2,
	"evening": 0.6,
	"night": 0.8
}
#main time loop
func _process(delta):
	if is_paused:
		return

	current_time += delta * time_speed * 0.01
	current_time = clamp(current_time, 0.0, 1.0)


	emit_signal("time_updated", current_time)

	_check_day_moments()

	if current_time >= 1.0:
		emit_signal("day_ended")
		current_time = 0.0
		emit_signal("day_started")

var has_triggered_morning := false
var has_triggered_evening := false
var has_triggered_night := false


# These are the functions defined

#Brodcasts whem morning, evening and night start
func _check_day_moments():
	if !has_triggered_morning and current_time >= transition_thresholds["morning"]:
		has_triggered_morning = true
		print("🌅 Morning started")

	if !has_triggered_evening and current_time >= transition_thresholds["evening"]:
		has_triggered_evening = true
		print("🌆 Evening started")

	if !has_triggered_night and current_time >= transition_thresholds["night"]:
		has_triggered_night = true
		print("🌙 Night started")


#Skips to a new time
func skip_to(new_time: float):
	current_time = clamp(new_time, 0.0, 1.0)
	_reset_triggers()
	emit_signal("time_updated", current_time)

#Basically makes the game recheck whether it is day or night or evening
func _reset_triggers():
	has_triggered_morning = false
	has_triggered_evening = false
	has_triggered_night = false
