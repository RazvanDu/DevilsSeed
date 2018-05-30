extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var color = Color(1, 0, 0)
var length

func _draw():
	#var img = ImageTexture.new()
	#img.load("hudhpfill")
	#draw_texture(img,Vector2(100,100),Color(1,1,1,1))
	length = get_tree().get_root().get_node("root/Savu").hp * 107 / 100
	draw_rect(Rect2(Vector2(-75,-4),Vector2(length,16)),color)
	update()
	pass

func _ready():
	self.set_position(Vector2(125,35))
	pass

func _process(delta):
	_draw()
	pass
