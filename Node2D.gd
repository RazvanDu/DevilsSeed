extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var red = Color(1, 0, 0)
var green = Color(0, 01, 0)
var length = 0

func _draw():
	#var img = ImageTexture.new()0
	#draw_texture(img,Vector2(100,100),Color(1,1,1,1))
	length = get_tree().get_root().get_node("root/Savu").hp * 107 / 100
	draw_rect(Rect2(Vector2(-75,-4),Vector2(length,16)),red)
	length = get_tree().get_root().get_node("root/Savu").stamina * 77 / 500
	draw_rect(Rect2(Vector2(-80,30),Vector2(length,12)),green)
	update()
	pass

func _ready():
	self.set_position(Vector2(125,35))
	pass

func _process(delta):
	_draw()
	pass
