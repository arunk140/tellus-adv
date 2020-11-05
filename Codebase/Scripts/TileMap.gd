extends TileMap

const CHUNK_SIZE = 1000
const TILE_SIZE = 32
const NUM_CHUNKS_LOADED = 2

var current_chunk_min_x = 0
var current_chunk_max_x = 0
var current_chunk = 0

var minChunk = 0
var maxChunk = 0

var loadMin = 0
var loadMax = 0
var _tileset

func _ready():
	_tileset = get_tileset()
	load_new_chunk()

	
	
func _process(_delta):
	var current_pos = get_node("../Player/Camera2D").get_camera_position()
	var xPos = current_pos.x
	if (xPos > (loadMax-CHUNK_SIZE) || xPos < (loadMin+CHUNK_SIZE)):
		update_current_chunk_min(xPos)

func update_current_chunk_min(x):
	current_chunk_min_x = int(x) - (int(x)%CHUNK_SIZE)
	current_chunk_max_x = current_chunk_min_x + CHUNK_SIZE
	current_chunk = current_chunk_min_x/CHUNK_SIZE
	load_new_chunk()

func load_new_chunk():
	current_chunk_max_x = current_chunk_min_x + CHUNK_SIZE
	for chunk_index in range(NUM_CHUNKS_LOADED):
		minChunk = current_chunk - (chunk_index+1)
		maxChunk = current_chunk + (chunk_index+1)
	loadMin = minChunk * CHUNK_SIZE
	loadMax = maxChunk * CHUNK_SIZE
	var temp = 0
	for loc in range(loadMin, loadMax, TILE_SIZE):
		print(loc)
		addTile(loc, 270, "10")
		for inc in range(3):
			addTile(loc, 270+((inc+1)*32), "4")
			temp = inc
		addTile(loc, 270+((temp+2)*32), "7")

func addTile(x, y, tileID):
	var tile_loc = int(x)-(int(x)%TILE_SIZE) + 1
	var tile_pos = world_to_map(Vector2(tile_loc, y))
	set_cellv(tile_pos, _tileset.find_tile_by_name(tileID))
