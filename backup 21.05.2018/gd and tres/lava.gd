extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	var dist = self.get_position() - get_tree().get_root().get_node("root/player").get_position()
	dist = sqrt(pow(dist.x,2) + pow(dist.y,2))
	if dist < 100:
		get_tree().get_root().get_node("root/player").hp = -100
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	print(dist)
	pass
