extends Camera2D

#THIS DOES NOT WORK

@onready var tilemap = $"../tilemap"

func _ready():
	var rect = tilemap.get_used_rect()
	var cell_size = tilemap.tile_set.tile_size
	
	limit_left = rect.position.x * cell_size.x
	limit_top = rect.position.y * cell_size.y
	limit_right = (rect.position.x + rect.size.x) * cell_size.x
	limit_bottom = (rect.position.y + rect.size.y) * cell_size.y
