extends Node

var player_current_attack = false
var dreams_collected = 0

func _process(delta):
	if dreams_collected == 25:
		dreams_collected = 0

@onready var bjørn_scene = load("res://Scens/bjørn.tscn")
@onready var papir_scene = load("res://Scens/papirsfly.tscn")
@onready var coin_scene = load("res://Scens/coin.tscn")
@onready var player_scene = load("res://Scens/player.tscn")
@onready var gumball_scene = load("res://Scens/Gumball.tscn")
@onready var ghost_scene = load("res://Scens/ghost.tscn")
@onready var spawner_scene = load("res://Scens/Enemy spawner.tscn")
