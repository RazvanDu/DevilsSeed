extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const WALK_SPEED = 50

var hp = 40
var attack = 20
var attackdelay = 0

var velocity = Vector2()
var motion = Vector2()
var movedelay = 0
var jumpdelay = 0
var timer = null 
var anim = "idle"

func _follow_player(delta):
	if self.get_position().x > get_tree().get_root().get_node("root/Savu").get_position().x:
		motion.x = -WALK_SPEED
		$npccollision/SkeletonSprite.set_flip_h(false)
		
		if anim != "walk":
			anim = "walk"
			$npccollision/SkeletonSprite.play( anim )
	else:
		motion.x = WALK_SPEED
		$npccollision/SkeletonSprite.set_flip_h(true)
		
		if anim != "walk":
			anim = "walk"
			$npccollision/SkeletonSprite.play(anim)
			
	if self.get_position().y - get_tree().get_root().get_node("root/Savu").get_position().y >= 32:
		if jumpdelay > 2:
			motion.y = -300
			jumpdelay = 0
	else:
		motion.y += delta * 500
	pass

func timeoutcomplete():
	if !get_tree().get_root().get_node("root/Savu").parry:
		get_tree().get_root().get_node("root/Savu").hp -= attack
	timer.stop()

func _stop():
	motion.x = 0
	pass

func _attack_player():
	if attackdelay > 1.5:
		$npccollision/SkeletonSprite.play("attack")
		timer.start()
		attackdelay = 0
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
	if attackdelay >= 0.2:
		$npccollision/SkeletonSprite.play("idle")
		
	motion.y += delta * 500
	movedelay += delta
	jumpdelay += delta
	var dist = self.get_position() - get_tree().get_root().get_node("root/Savu").get_position()
	dist = sqrt(pow(dist.x,2) + pow(dist.y,2))
	
	if is_on_floor():
		motion.y = 500
	if dist < 300:
		anim = "walk"
		$npccollision/SkeletonSprite.play(anim)
		_follow_player(delta)
		
	else:
		anim = "idle"
		$npccollision/SkeletonSprite.play(anim)
		_stop()
		
	if dist <= 100:
		attackdelay += delta
		_attack_player()
		hp -= get_tree().get_root().get_node("root/Savu").attack
		
	else: 
		attackdelay = 0
	if hp <= 0:
		self.queue_free()
		
	self.move_and_slide(motion,Vector2(0,-10))	
	pass