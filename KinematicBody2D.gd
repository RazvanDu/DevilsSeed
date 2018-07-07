extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const GRAVITY = 50.0
const WALK_SPEED = 200

var attack = 0
var hp = 100

var velocity = Vector2()
var motion = Vector2()
var jump = 0
var jumpdelay = 0
var attackdelay = 0
var anim = "savuidle"
var parry = 0
var parrydelay = 0
var parrytime = 0
var stamina = 500
var potionstock = 0
var potiondelay= 0
var hittime = 0
var dir = "left"
var airtime = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _parry():
	#if parrytime < 1:
	#	if parry == 0 and parrydelay > 1:
	#		parry = 1
	#	else:
	#		parry = 0
	#else:
	#	 parrytime = 0
	anim = "savuparry"
	stamina -= 5
	parry = 1
	pass

func hit():
	if hittime < 0.2 and anim != "savuparry":
		anim = "savuhit"
		if dir == "left":
			velocity.y = -50
			velocity.x = -50
		else:
			velocity.y = -50
			velocity.x = 50
	elif anim == "savuhit":
		anim = "savuidle"
		hittime = 1
	pass

func _physics_process(delta):
	if stamina < 500:
		stamina += 1
	if hp <= 0:
		get_tree().reload_current_scene()
	attackdelay += delta
	parrydelay += delta
	potiondelay += delta
	hittime += delta
	attack = 0
	if is_on_floor():
		airtime = 0
		if anim == "savuparry":
			anim = "savuidle"
		if anim == "savurun" and !Input.is_key_pressed(KEY_D) and !Input.is_key_pressed(KEY_A):
			anim = "savuidle"
		if anim == "savufall":
			anim = "savuidle"
		jumpdelay = 0
		velocity.y = 0
		jump = 0
		if Input.is_key_pressed(KEY_SHIFT)  and !Input.is_key_pressed(KEY_SPACE) and !Input.is_key_pressed(KEY_W) and !Input.is_key_pressed(KEY_D) and !Input.is_key_pressed(KEY_A) and stamina > 5:
			_parry()
			parrydelay = 0
			motion.x = 0
		else: 
			parry = 0
		if (Input.is_key_pressed(KEY_W) or is_on_wall() and Input.is_key_pressed(KEY_W) and jumpdelay > 0.5) and stamina > 100:
			airtime = 0
			velocity.y = -300
			jump = 1
			stamina -= 50
			if anim == "savuidle" or anim == "savurun":
				anim = "savujump"
	#if Input.is_key_pressed(KEY_W):
		#velocity.y = -200
	#elif Input.is_key_pressed(KEY_S):
	  	 #velocity.y =  200
	else:
		airtime += delta
		jumpdelay += delta
		velocity.y += log(1+airtime)* GRAVITY
		if velocity.y >= 0 and anim == "savujump":
			anim = "savufall"
		if Input.is_key_pressed(KEY_A):
			get_tree().get_root().get_node("root/player/CollisionShape2D/AnimatedSprite").set_flip_h( true )
			velocity.x = -WALK_SPEED
			if anim == "savuidle":
				anim = "savurun"
		elif Input.is_key_pressed(KEY_D):
			get_tree().get_root().get_node("root/player/CollisionShape2D/AnimatedSprite").set_flip_h( false )
			velocity.x =  WALK_SPEED
			if anim == "savuidle":
				anim = "savurun"
		else:
			velocity.x = 0
		if Input.is_key_pressed(KEY_W) and jump == 1 and jumpdelay > 0.5  or is_on_wall() and Input.is_key_pressed(KEY_W) and jumpdelay > 0.5 and stamina > 100:
			airtime = 0
			if anim != "savujump":
				anim = "savujump"
			velocity.y = -300
			jump = 2
			stamina -= 50
	if is_on_ceiling():
		jump = 2
		velocity.y = log(1+airtime) * GRAVITY
	if attackdelay < 0.5:
		velocity.x = 0;
	elif anim == "savuattack1" or anim == "savuattack2":
		anim = "savuidle"
	if !Input.is_key_pressed(KEY_SHIFT) and Input.is_key_pressed(KEY_SPACE) and attackdelay > 0.6 and is_on_floor() and stamina > 50 and hittime > 0:
		attack = 20
		attackdelay = 0
		stamina -= 50
		var rand = randi() % 2
		if rand == 1: 
			anim = "savuattack1"
		else:
			anim = "savuattack2"
	if Input.is_key_pressed(KEY_X) and potiondelay > 1 and potionstock > 0:
		if hp <= 50:
			hp += 50
		else:
			hp = 100
		potiondelay = 0
		potionstock -= 1
	hit()
	self.move_and_slide(velocity,Vector2(0,-10))
	get_tree().get_root().get_node("root/player/CollisionShape2D/AnimatedSprite").play(anim)
	print(potionstock)



func _on_Area2D_area_entered(area):
	pass # replace with function body
