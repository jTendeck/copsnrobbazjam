extends Node

var current_player_number = 4

#bool is var is_robber
var player1 = Player.new(false)
var player2 = Player.new(false)
var player3 = Player.new(true)
var player4 = Player.new(true)

var players = [player1,player2,player3,player4]

var global_time = 100

var player_positions = {0:Vector2(0,0), 1:Vector2(0,0), 2:Vector2(0,0), 3:Vector2(0,0)}

var point_values = {"second":1, "treasure":200}


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


enum PlayerType { ROBBER, POLICE }

var all_players : Dictionary
var police : Dictionary
var robbers : Dictionary

const MAX_PLAYERS: int = 4

var game_can_start : bool

func _ready() -> void:
	SignalManager.player_joined.connect(add_player)
	SignalManager.team_lost.connect(_on_team_lost)
	SignalManager.player_killed.connect(_on_player_killed)
	SignalManager.money_delivered.connect(_on_money_delivered)
	SignalManager.time_expired.connect(_on_time_expired)
	SignalManager.max_players_joined.connect(_on_enough_players_joined)
	SignalManager.not_enough_players.connect(_on_not_enough_players_joined)
	SignalManager.player_disconnected.connect(_on_player_disconnected)


func add_player(player: JtPlayer):
	all_players[player.name] = player
	if (player.player_type == GlobalVariables.PlayerType.ROBBER):
		robbers[player.name] = player
	if (player.player_type == GlobalVariables.PlayerType.POLICE):
		police[player.name] = player
	SignalManager.player_joined_success.emit()
	if (all_players.size() >= MAX_PLAYERS):
		SignalManager.max_players_joined.emit()
		
		
func remove_player(player_name: String):
	var p : JtPlayer = all_players[player_name]
	p.call_deferred("queue_free")
	all_players.erase(player_name)
	robbers.erase(player_name)
	police.erase(player_name)
	if (all_players.size() < MAX_PLAYERS):
		SignalManager.not_enough_players.emit()
	if (robbers.size() < 1 or police.size() < 1):
		SignalManager.end_game.emit()
		
		
func _on_player_killed(player: JtPlayer):
	var alive : int = 0
	var t : GlobalVariables.PlayerType = player.player_type
	if (t == GlobalVariables.PlayerType.ROBBER):
		alive = count_alive(robbers)
	if (t == GlobalVariables.PlayerType.POLICE):
		alive = count_alive(police)
		
	if (alive <= 0):
		SignalManager.team_lost.emit(player)
	
	
func count_alive(collection: Dictionary) -> int:
	var c : int = 0
	for p in collection.values():
		if p is JtPlayer:
			var guy : JtPlayer = p as JtPlayer
			if guy.enabled:
				c += 1
	return c
	
	
func _on_money_delivered(_by: JtPlayer):
	SignalManager.police_lost.emit(null)
	
	
func _on_team_lost(jt_player: JtPlayer):
	if (jt_player.player_type == GlobalVariables.PlayerType.ROBBER):
		SignalManager.robbers_lost.emit(jt_player)
	if (jt_player.player_type == GlobalVariables.PlayerType.POLICE):
		SignalManager.police_lost.emit(jt_player)
		
		
func _on_time_expired():
	SignalManager.robbers_lost.emit(null)

func _on_enough_players_joined():
	game_can_start = true
	
func _on_not_enough_players_joined():
	game_can_start = false

func _on_player_disconnected(id: int):
	remove_player(str(id))
