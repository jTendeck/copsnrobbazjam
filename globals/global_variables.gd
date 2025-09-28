extends Node

enum PlayerType { ROBBER, POLICE }

var all_players : Dictionary
var police : Dictionary
var robbers : Dictionary


func _ready() -> void:
	SignalManager.player_joined.connect(add_player)
	SignalManager.team_lost.connect(_on_team_lost)
	SignalManager.player_killed.connect(_on_player_killed)
	SignalManager.money_delivered.connect(_on_money_delivered)
	SignalManager.time_expired.connect(_on_time_expired)


func add_player(player: JtPlayer):
	all_players[player.name] = player
	if (player.player_type == GlobalVariables.PlayerType.ROBBER):
		robbers[player.name] = player
	if (player.player_type == GlobalVariables.PlayerType.POLICE):
		police[player.name] = player
		
		
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
