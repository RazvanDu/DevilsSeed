extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var timer = null
func _ready():
	timer = Timer.new()
	timer.set_wait_time(2)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func on_timeout_complete():
	get_tree().change_scene("res://sceneta.tscn")
	
func _on_Button_pressed():
	timer.start()
	
