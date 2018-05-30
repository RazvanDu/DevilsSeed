extends RichTextLabel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _mesajeul():
	print("hei")
	pass
	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	self.clear()
	self.add_text(String(get_tree().get_root().get_node("root/player").hp) +  "HP")
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass
