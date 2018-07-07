extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const WALK_SPEED = 50

var hp = 500
var attack = 5
var attackdelay = 0

var velocity = Vector2()
var motion = Vector2()
var movedelay = 0
var movedir = "left"
var jumpdelay = 0
var timer = null 
var anim = "idle"
var dist = 0
var combodelay = 0
var arrowdelay = 0
var dir = "left"
var hittime = 0

func timeoutcomplete():
	if !get_tree().get_root().get_node("root/player").parry:
		get_tree().get_root().get_node("root/player").hp -= attack
	timer.stop()

func hit():
	if hittime < 0.2 and anim != "hit":
		anim = "hit"
		motion.y = -100
		if self.get_position().x < get_tree().get_root().get_node("root/player").get_position().x:
			motion.x = -100
		else:
			motion.x = 100
	elif anim == "hit":
		anim = "idle"
		hittime = 1
	pass

func _attack_player():
	if attackdelay > 0.5 and combodelay < 2:
		anim = "attack"
		get_tree().get_root().get_node("root/player").hittime = 0
		get_tree().get_root().get_node("root/player").dir = dir
		timer.start()
		attackdelay = 0
	elif combodelay > 3.5:
		combodelay = 0
	pass

func _shootarrow(dist):
	var angle = atan((self.get_position().x - get_tree().get_root().get_node("root/player").get_position().x) / (self.get_position().y - get_tree().get_root().get_node("root/player").get_position().y))
	if arrowdelay > 3:
		get_tree().get_root().get_node("root/sajeata").shoot(self.get_position(),angle,dir)
		arrowdelay = 0
		get_tree().get_root().get_node("root/sajeata").dist = dist
	pass

func _follow_player(delta):
	if dist <= 60:
		attackdelay += delta
		combodelay += delta
		_attack_player()
		if get_tree().get_root().get_node("root/player").attack > 0:
			hp -= get_tree().get_root().get_node("root/player").attack
			hittime = 0
	else: 
		attackdelay = 0
		if self.get_position().x > get_tree().get_root().get_node("root/player").get_position().x:
			motion.x = -WALK_SPEED
			dir = "left"
			get_tree().get_root().get_node("root/" + self.get_name() + "/npccollision/AnimatedSprite").set_flip_h( false )
			if anim != "walk":
				anim = "walk"
		else:
			motion.x = WALK_SPEED
			dir = "right"
			get_tree().get_root().get_node("root/" + self.get_name() + "/npccollision/AnimatedSprite").set_flip_h( true )
			if anim != "walk":
				anim = "walk"
		if self.get_position().y - get_tree().get_root().get_node("root/player").get_position().y >= 32 and is_on_wall():
			if jumpdelay > 2:
				motion.y = -400
				jumpdelay = 0
		else:
			motion.y += delta * 500
	pass

func _ready():
	timer = Timer.new()
	timer.set_wait_time(0.2)
	timer.connect("timeout",self,"timeoutcomplete")
	add_child(timer) 
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	hittime += delta
	if attackdelay >= 0.2:
		anim = "idle"
	motion.y += delta * 500
	motion.x = 0
	jumpdelay += delta
	arrowdelay += delta
	dist = self.get_position() - get_tree().get_root().get_node("root/player").get_position()
	dist = sqrt(pow(dist.x,2) + pow(dist.y,2))
	if is_on_floor():
		motion.y = 0
	if dist < 600:
		_shootarrow(dist)
		_follow_player(delta)
	else:
		anim = "idle"
	if hp <= 0:
		self.queue_free()
	hit()
	self.move_and_slide(motion,Vector2(0,-10))
	get_tree().get_root().get_node("root/" + self.get_name() + "/npccollision/AnimatedSprite").play(anim)
	print(hp)
	pass