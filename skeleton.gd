extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const WALK_SPEED = 50

var hp = 60
var attack = 5
var attackdelay = 0

var velocity = Vector2()
var motion = Vector2()
var movedelay = 0
var movedir = "left"
var jumpdelay = 0
var timer = null 
var timer2 = null 
var anim = "idle"
var dist = 0
var combodelay = 0
const counter = 100
var hitTime = 0 

func ishit():
	if hitTime<0.2:
		anim="hit"
	elif anim=="hit":
		anim="idle"
		hitTime=1
	pass

func timeoutcomplete():
	if !get_tree().get_root().get_node("root/Savu").parry:
		get_tree().get_root().get_node("root/Savu").hp -= attack
	timer.stop()
func _attack_player():
	if attackdelay > 0.5 and combodelay < 2:
		anim = "attack"
		get_tree().get_root().get_node("root/Savu").hittime=0
		timer.start()
		attackdelay = 0
	elif combodelay > 3.5:
		combodelay = 0
	pass

func _follow_player(delta):
	if dist <= 60:
		attackdelay += delta
		combodelay += delta
		print(combodelay)
		_attack_player()
		hp -= get_tree().get_root().get_node("root/Savu").attack
	else: 
		attackdelay = 0
		if self.get_position().x > get_tree().get_root().get_node("root/Savu").get_position().x:
			motion.x = -WALK_SPEED
			get_tree().get_root().get_node("root/skeleton/npccollision/SkeletonSprite").set_flip_h( false )
			if anim != "walk":
				anim = "walk"
		else:
			motion.x = WALK_SPEED
			get_tree().get_root().get_node("root/skeleton/npccollision/SkeletonSprite").set_flip_h( true )
			if anim != "walk":
				anim = "walk"
		if self.get_position().y - get_tree().get_root().get_node("root/Savu").get_position().y >= 32 and is_on_wall():
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
	hitTime+=delta
	if attackdelay >= 0.2:
		anim = "idle"
	motion.y += delta * 500
	motion.x = 0
	jumpdelay += delta
	dist = self.get_position() - get_tree().get_root().get_node("root/Savu").get_position()
	dist = sqrt(pow(dist.x,2) + pow(dist.y,2))
	if is_on_floor():
		motion.y = 0
	if dist < 300:
		_follow_player(delta)
	else:
		anim = "idle"
	if hp <= 0:
		self.queue_free()
	self.move_and_slide(motion,Vector2(0,-10))
	get_tree().get_root().get_node("root/skeleton/npccollision/SkeletonSprite").play(anim)
	pass