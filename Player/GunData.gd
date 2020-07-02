extends Node

class_name GunData

var guns = {
	"Glock19" : {
		fire_rate = 0.1,
		clip_size = 15,
		reload_rate = 2,
		total_ammo = 75,
		max_ammo = 150,
		fire_range = 50
	},
	"Shotgun" : {
		fire_rate = 2,
		clip_size = 2,
		reload_rate = 1,
		total_ammo = 5,
		max_ammo = 60,
		fire_range = 10
	},
	"AK47" : {
		fire_rate = 0.1,
		clip_size = 30,
		reload_rate = 1,
		total_ammo = 120,
		max_ammo = 300,
		fire_range = 350
	},
	"Knife" : {
		fire_rate = 2,
		clip_size = null,
		reload_rate = null,
		total_ammo = null,
		max_ammo = null,
		fire_range = 2
	}
}
