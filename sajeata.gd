extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var motion = Vector2(0,0)
var dist = 0 
var ang = 0
var initang = 0

func shoot(pos,angle,dir):
	if dir == "left":
		self.set_position(pos-Vector2(50,0))
		if angle > 0:
			self.set_rotation( PI / 2 - angle )
			initang = round(rad2deg( PI / 2 - angle ))
			motion.x = -sin(angle) * 500
			motion.y = -cos(angle) * 500
		else:
			self.set_rotation( - PI / 2 - angle )
			initang = round(rad2deg( - PI / 2 - angle ))
			motion.x = -cos(angle) * 500
			motion.y = -sin(angle) * 500
	else:
		self.set_position(pos+Vector2(50,0))
		if angle > 0:
			self.set_rotation( - angle - PI / 2 )
			initang = round(rad2deg( - angle - PI / 2 ))
			motion.y = cos(angle) * 500
			motion.x = sin(angle) * 500
			
		else:
			self.set_rotation( - angle + PI / 2 )
			initang = round(rad2deg( - angle + PI / 2 ))
			motion.x = -sin(angle) * 500
			motion.y = -cos(angle) * 500
	ang = initang
	pass

func _ready():
	self.set_position(Vector2(-1000,-1000))
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
	if is_on_floor() or is_on_ceiling() or is_on_wall():
		motion = Vector2(0,0)
	elif ang != -90  and dist != 0:
		ang += 1 
		self.set_rotation( deg2rad( ang ) )
		motion.y += 1000 / dist
	self.move_and_slide(motion,Vector2(0,-10))
	
	pass


func _on_Area2D_body_entered(body):
	if body == self:
		get_tree().get_root().get_node("root/player").hp -= 10
		get_tree().get_root().get_node("root/player").hittime = 0
		self.motion = Vector2(0,0)
		self.set_position(Vector2(-1000,-1000))
	pass # replace with function body
