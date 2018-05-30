extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const GRAVITY = 20.0
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
var timer2 = null

func _ready():
	pass

			
func _parry():
	if parrytime < 1:
		if parry == 0 and parrydelay > 1:
			parry = 1
		else:
			parry = 0
	else:
		 parrytime = 0
	pass

func _physics_process(delta):
	if hp <= 0:
		get_tree().reload_current_scene()
	attackdelay += delta
	parrydelay += delta
	attack = 0
	if is_on_floor():
		if anim == "savurun" and !Input.is_key_pressed(KEY_D) and !Input.is_key_pressed(KEY_A):
			anim = "savuidle"
			$CollisionShape2D/playersprite.play(anim)
			
		if anim == "savufall":
			anim = "savuidle"
			$CollisionShape2D/playersprite.play(anim)
			
		jumpdelay = 0
		velocity.y = 0
		jump = 0
		
		if Input.is_key_pressed(KEY_W):
			velocity.y = -300
			jump = 1
			if anim == "savuidle" or anim == "savurun":
				anim = "savujump"
				$CollisionShape2D/playersprite.play(anim)
				
	else:
		jumpdelay += delta
		velocity.y += GRAVITY
		
		if velocity.y >= 0 and anim == "savujump":
			anim = "savufall"
			$CollisionShape2D/playersprite.play(anim)
			
		if Input.is_key_pressed(KEY_A):
			$CollisionShape2D/playersprite.set_flip_h( true )
			velocity.x = -WALK_SPEED
			if anim == "savuidle":
				anim = "savurun"
				$CollisionShape2D/playersprite.play(anim)
				
		elif Input.is_key_pressed(KEY_D):
			$CollisionShape2D/playersprite.set_flip_h( false )
			velocity.x =  WALK_SPEED
			if anim == "savuidle":
				anim = "savurun"
				$CollisionShape2D/playersprite.play(anim)
				
		else:
			velocity.x = 0
			
		if Input.is_key_pressed(KEY_W) and jump == 1 and jumpdelay > 0.2:
			if anim != "savujump":
				anim = "savujump"
				$CollisionShape2D/playersprite.play(anim)
				
			velocity.y = -300
			jump = 2
			
	if is_on_ceiling():
		jump = 2
		velocity.y = delta * GRAVITY
		
	if Input.is_key_pressed(KEY_SPACE) and attackdelay > 0.5:
		attack()
			#$CollisionShape2D/playersprite.play("idle")
		
	if Input.is_key_pressed(KEY_SHIFT):
		_parry()
		parrydelay = 0
		
	self.move_and_slide(velocity,Vector2(0,-10))
	print(anim)
	
func attack():
	attack = 20
	attackdelay = 0
	anim = "savuattack"
	$CollisionShape2D/playersprite.play(anim) 
	
func _on_Area2D_body_entered(body):
	hp = 0
	pass # replace with function body

func _on_Area2D2_body_entered(body):
	hp = 0
	pass # replace with function body
