extends RichTextLabel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	self.push_color( Color(0,0,0) )
	self.set_position( Vector2(970,40) )
	self.add_text( "X" + String(get_tree().get_root().get_node("root/player").potionstock) )
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	self.clear()
	self.push_color( Color(0,0,0) )
	self.add_text( "X" + String(get_tree().get_root().get_node("root/player").potionstock) )
	pass
