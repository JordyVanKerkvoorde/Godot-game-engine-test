extends Node

class_name Weapon

export var fire_rate = 0.5
export var clip_size = 5
export var reload_rate = 1
export var total_ammo = 200
export var max_ammo = 200
export var fire_range = 10

onready var ammo_label = $"/root/World/UI/Label"
onready var raycast = $"../Head/Camera/RayCast"
onready var weapons = get_node("../WeaponData").get("guns")

var current_ammo = 0
var can_fire = true
var reloading = false

var current_weapon = "Glock19"


func _ready():
	raycast.cast_to = Vector3(0, 0, -fire_range)
	current_ammo = clip_size
	change_weapon(current_weapon)
	
func _process(delta):
	if reloading:
		ammo_label.set_text("Reloading...")
	else:
		ammo_label.set_text("%d / %d"% [current_ammo, total_ammo])
	
	if Input.is_action_just_pressed("primary_fire") and can_fire:
		if current_ammo > 0 and not reloading:
			fire()
		elif not reloading and has_ammo():
			reload()
	if Input.is_action_just_pressed("reload") and not reloading and has_ammo():
		reload()

func has_ammo():
	return total_ammo != 0

func check_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Enemies"):
			collider.queue_free()
			print("Killed " + collider.name)

func fire():
	print("Weapon fired!")
	can_fire = false
	current_ammo -= 1
	check_collision()
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true

func reload():
		print("Reloading...")
		reloading = true
		yield(get_tree().create_timer(reload_rate), "timeout")
		
		manage_ammo()
		
		reloading = false

func manage_ammo():
		
	var needed = clip_size - current_ammo
	
	if total_ammo >= needed:
		total_ammo -= needed
		current_ammo = clip_size
	elif total_ammo < needed:
		current_ammo = total_ammo
		total_ammo = 0
		

func reload_ammo():
	total_ammo = max_ammo
	current_ammo = clip_size
	

func change_weapon(type):
	current_weapon = type
	fire_rate = weapons[type].fire_rate
	clip_size = weapons[type].clip_size
	reload_rate = weapons[type].reload_rate
	total_ammo = weapons[type].total_ammo
	max_ammo = weapons[type].max_ammo
	fire_range = weapons[type].fire_range
	
