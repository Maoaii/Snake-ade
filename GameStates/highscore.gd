extends Label

var highscore = 0 setget set_highscore

func _ready():
	load_highscore()


func load_highscore():
	var file = File.new()
	if not file.file_exists(Global.filepath): return
	file.open(Global.filepath, File.READ)
	highscore = file.get_var()
	file.close()


func save_highscore():
	var file = File.new()
	file.open(Global.filepath, File.WRITE)
	file.store_var(highscore)
	file.close()

func set_highscore(new_highscore):
	highscore = new_highscore
	save_highscore()
