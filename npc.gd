extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const WALK_SPEED = 100

var hp = 100
var attack = 20
var attackdelay = 0

var velocity = Vector2()
var motion = Vector2()
var movedelay = 0
var movedir = "left"
var jumpdelay = 0
var dist = 0

func _attack_player():
	if attackdelay > 2 and !get_tree().get_root().get_node("root/player").parry:
		get_tree().get_root().get_node("root/player").hp -= attack
		get_tree().get_root().get_node("root/player").hit()
		attackdelay = 0
	pass

func _follow_player(delta):
	if dist < 50:
		motion.x = 0
		attackdelay += delta
		_attack_player()
		hp -= get_tree().get_root().get_node("root/player").attack
	else:
		if self.get_position().x > get_tree().get_root().get_node("root/player").get_position().x:
			motion.x = -WALK_SPEED
			get_tree().get_root().get_node("root/npc/npccollision/AnimatedSprite").set_flip_h( true )
		else:
			motion.x = WALK_SPEED
			get_tree().get_root().get_node("root/npc/npccollision/AnimatedSprite").set_flip_h( false )
	if self.get_position().y - get_tree().get_root().get_node("root/player").get_position().y >= 32 and is_on_wall():
		if jumpdelay > 2:
			motion.y = -300
			jumpdelay = 0
	else:
		motion.y += delta * 500
	pass

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	motion.y += delta * 500
	movedelay += delta
	jumpdelay += delta
	dist = self.get_position() - get_tree().get_root().get_node("root/player").get_position()
	dist = sqrt(pow(dist.x,2) + pow(dist.y,2))
	if is_on_floor():
		motion.y = 500
	if dist < 300:
		_follow_player(delta)
	else: 
		attackdelay = 0
	if hp <= 0:
		self.queue_free()
	#if movedelay < 2:
	#	if movedir == "left":
	#		self.move_and_slide(Vector2(-WALK_SPEED,0),Vector2(0,-10))
	#	else:
	#		self.move_and_slide(Vector2(WALK_SPEED,0),Vector2(0,-10))
	else:
		movedelay = 0
		if movedir == "left":
			#get_tree().get_root().get_node("root/npc/npccollision/AnimatedSprite").set_flip_h( false )
			movedir = "right"
		else:
			#get_tree().get_root().get_node("root/npc/npccollision/AnimatedSprite").set_flip_h( true )
			movedir = "left"
	self.move_and_slide(motion,Vector2(0,-10))	
	pass