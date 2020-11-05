extends Node

export var fade_in_duration = 3
export var fade_out_duration = 1
export var transition_type = 1 # TRANS_SINE

const MAX_VOL = -20
const MIN_VOL = -60

onready var audiostream = $AudioStreamPlayer

var is_paused = false

func _ready():
	fade_in()

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if is_paused:
			fade_in()
		else:
			fade_out()
		is_paused = !is_paused

func fade_out():
	$Tween.interpolate_property($AudioStreamPlayer, "volume_db", MAX_VOL, MIN_VOL, fade_out_duration, transition_type, Tween.EASE_IN, 0)
	$Tween.start()
		
func fade_in():
	$Tween.interpolate_property($AudioStreamPlayer, "volume_db", MIN_VOL, MAX_VOL, fade_in_duration, transition_type, Tween.EASE_IN, 0)
	$Tween.start()



