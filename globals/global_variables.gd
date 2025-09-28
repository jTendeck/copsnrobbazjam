extends Node

var current_player_number = 4

var player1 = Player.new(false)
var player2 = Player.new(false)
var player3 = Player.new(true)
var player4 = Player.new(true)

var players = [player1,player2,player3,player4]

var global_time = 100

var player_positions = {0:Vector2(0,0), 1:Vector2(0,0), 2:Vector2(0,0), 3:Vector2(0,0)}

var point_values = {"second":25, "treasure":200}


class Player:
	
	var score = 0
	var position = Vector2(0,0)
	var health = 100
	
	var player_controls : CharacterBody2D
	
	var is_robber : bool
	
	func _init(_is_robber: bool) -> void:
		is_robber = _is_robber



class Treasure:
	
	var value = 200

	var position = Vector2(0,0)
	
	var seconds_to_recieve = 5
