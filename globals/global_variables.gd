extends Node

var current_player_number = 4

var player1 = Player.new()
var player2 = Player.new()
var player3 = Player.new()
var player4 = Player.new()

var players = [player1,player2,player3,player4]

var global_time = 100


var player_positions = {0:Vector2(0,0), 1:Vector2(0,0), 2:Vector2(0,0), 3:Vector2(0,0)}

var point_values = {"second":25, "treasure":200}





class Player:
	
	var score = 0
	var position = Vector2(0,0)
	var health = 100
	
