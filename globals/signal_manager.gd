extends Node

signal player_fire(projectile_owner: JtPlayer, projectile: PackedScene, location: Vector2, angle: float, velocity: Vector2)
signal spawn_scene(scene: PackedScene, location: Vector2)
signal player_hit(player: JtPlayer, hit_by: Projectile)
signal player_killed(player: JtPlayer)
signal money_picked_up(by: JtPlayer, money_bag: MoneyBag)
signal player_picking_up_money(by: JtPlayer)
signal player_stopped_picking_up_money(by: JtPlayer)
signal money_dropped(money_bag: MoneyBag)
signal money_delivered(by: JtPlayer)
signal time_expired()