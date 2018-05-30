extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var x = 0 
func _ready():
	set_ofs()
	if(animation=="savuattack"):
		connect("frame_changed", self, "set_ofs")
	pass

var offsets	= [Vector2(0,0),Vector2(0,0),Vector2(0,2),Vector2(0,2),Vector2(0,1),Vector2(0,0),Vector2(0,1),Vector2(0,4), Vector2(0,4), Vector2(0,4)]
func set_ofs():
	set_offset(offsets[get_frame()])
	
func _process(delta):
	pass
func _on_Button_pressed():
	play("hand")
