extends Node

var muted = false;

func play_ui():
	$AudioUiClick.play()

func play_bg():
	$AudioBGMusic.play()
	
func play_crash():
	$AudioGameCrash.play()

func play_flap():
	$AudioGameFlap.play()
	
func play_point():
	$AudioGamePoint.play()
	
func play_start():
	$AudioGameStart.play()

func toggle_mute():
	muted = !muted;
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_idx, muted)
