extends Node

const HTerrainData = preload("res://addons/zylann.hterrain/hterrain_data.gd")

@onready var _terrain = $HTerrain
@onready var timer_label = $CanvasLayer/TimerLabel

var time_left: int = 3600  # 1 hour in seconds

func _ready() -> void:
	# Get the image
	var data : HTerrainData = _terrain.get_data()
	var colormap : Image = data.get_image(HTerrainData.CHANNEL_COLOR)
	
	print(data)
	print(colormap)
	
	# Initialize the timer label
	update_timer_label()
	
	# Start the timer
	var timer = Timer.new()
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	timer.set_wait_time(1.0)
	timer.set_one_shot(false)
	add_child(timer)
	timer.start()

func _on_Timer_timeout() -> void:
	time_left -= 1
	if time_left >= 0:
		update_timer_label()
	else:
		# Timer has reached zero
		$Timer.stop()
		timer_label.text = "Time's up!"

func update_timer_label() -> void:
	var hours = time_left / 3600
	var minutes = (time_left % 3600) / 60
	var seconds = time_left % 60
	timer_label.text = "%02d:%02d:%02d" % [hours, minutes, seconds]
