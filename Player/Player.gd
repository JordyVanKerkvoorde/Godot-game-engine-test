extends KinematicBody

export var speed = 7
export var acceleration = 2
export var gravity = 0.98
export var jump_power = 50
export var mouseSensitivity = 0.3
export var max_health = 100.00
export var health = 100.00
export var max_armor = 100.00
export var armor = 0.00
export var has_armor = false

onready var head = $Head
onready var camera = $Head/Camera
onready var armor_label = get_node("/root/World/UI/ArmorLabel")
onready var health_label = get_node("/root/World/UI/HealthLabel")

var velocity = Vector3()
var camera_x_rotation = 0

var weapon_inventory = ["Glock19", "Shotgun", "AK47"]

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	update_ha_labels()

func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouseSensitivity))
		
		var x_delta = event.relative.y * mouseSensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	var headBasis = head.get_global_transform().basis
	
	change_weapon()
	
	var direction = Vector3()
	if Input.is_action_pressed("move_forward"): 
		direction -= headBasis.z
	elif Input.is_action_pressed("move_backward"): 
		direction += headBasis.z
	if Input.is_action_pressed("move_left"): 
		direction -= headBasis.x
	elif Input.is_action_pressed("move_right"):
		direction += headBasis.x
	
	#choose_weapon()
	
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity.y -= gravity
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y += jump_power
	
	velocity = move_and_slide(velocity, Vector3.UP)

func add_armor(armor_in):
	armor = armor_in
	
	if armor > max_armor:
		armor = max_armor

func add_health(health_in):
	health = health_in
	
	if health > max_health:
		health = max_health

func receive_damage(damage):
	var hdamage = damage - armor
	if hdamage > 0 : hdamage = 0
	var adamage = damage - hdamage
	
	armor -= adamage
	health -= hdamage

func update_ha_labels():
	armor_label.set_text("ARMOR: \n %.2f" % armor)
	health_label.set_text("HEALTH: \n %.2f" % health)
	
func change_weapon():
	if Input.is_action_just_pressed("weapon1"):
		get_node("Weapon").change_weapon(weapon_inventory[0])
	elif Input.is_action_just_pressed("weapon2"):
		get_node("Weapon").change_weapon(weapon_inventory[1])
	elif Input.is_action_just_pressed("weapon3"):
		get_node("Weapon").change_weapon(weapon_inventory[2])
	
	
	
	
	
	
