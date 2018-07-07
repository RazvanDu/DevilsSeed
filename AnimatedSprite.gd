extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var x = 0 
func _ready():
	    set_ofs()
	    if(get_tree().get_root().get_node("root/player").anim == "savuattack1"):
	    	print(get_tree().get_root().get_node("root/player").anim)
	    	connect("frame_changed", self, "set_ofs")
	    pass

var offsets = [Vector2(0,0),Vector2(0,0),Vector2(0,2),Vector2(0,2),Vector2(0,1),Vector2(0,0),Vector2(0,1),Vector2(0,4), Vector2(0,4), Vector2(0,4)]
func set_ofs():
	   set_offset(offsets[get_frame()])

func _process(delta):
	set_ofs()
	if get_tree().get_root().get_node("root/player").anim == "savuattack1":
		print(get_tree().get_root().get_node("root/player").anim)
		connect("frame_changed", self, "set_ofs")
	pass