extends Polygon2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	#self.color = Color(255,0,0,255)
	#Rect2 rect = Rect2(Vector2(0,0),Vector2(120,120))
	self.draw_rect(Rect2(Vector2(0,0),Vector2(120,120)), Color( 255, 0, 0, 255 ))
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
