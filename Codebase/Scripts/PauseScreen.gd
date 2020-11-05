extends CanvasLayer

var is_paused = false

func _ready():
	# Hide Pause Menu Elements on Load
	is_paused = false
	check()

func _input(_event):
	if get_tree().current_scene.name != 'TitleScreen':
		if Input.is_action_just_pressed("ui_cancel"):
			is_paused = !is_paused
			check()

func resume():
	is_paused = false
	check()

func check():
	$Background.visible = is_paused
	$ContinueBtn.visible = is_paused
	$FullscreenBtn.visible = is_paused
	$MainMenuBtn.visible = is_paused
	$ExitBtn.visible = is_paused
	get_tree().paused = is_paused

func _on_FullscreenBtn_pressed():
	OS.window_fullscreen = !OS.window_fullscreen

func _on_ExitBtn_pressed():
	get_tree().quit()

func _on_ContinueBtn_pressed():
	resume()

func _on_MainMenuBtn_pressed():
	resume()
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")
