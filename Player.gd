extends KinematicBody2D


var speed = 500
var bullet_speed = 2000
var bullet = preload("res://Bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var move = Vector2()
	if Input.is_action_pressed("up"):
		move.y-=1
	if Input.is_action_pressed("down"):
		move.y+=1
	if Input.is_action_pressed("left"):
		move.x-=1
	if Input.is_action_pressed("right"):
		move.x+=1
	
	move = move.normalized()
	move = move_and_slide(move*speed)
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("LMB"):
		fire()
	
func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)
