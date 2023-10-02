extends Control


@onready var parallax_background := $CanvasLayer/ParallaxBackground
@onready var play_button         := $Main/VBoxContainer/PlayButton


func _process(delta: float):
	parallax_background.scroll_offset.x -= 50 * delta


func _PlayButton_pressed():
	Global.start_new_game()


func _ExitButton_pressed():
	Global.exit_game()
	
	
func _SettingsButton_pressed():
	pass
