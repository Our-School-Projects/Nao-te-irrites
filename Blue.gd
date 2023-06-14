extends Path2D

var playerRun = [0,0,0,0]
var playerPos = [0,0,0,0]
signal playDoneBlue
signal outBoxBlue
var diceFace = 0
var playerTurn = 0
var initialPos = 0
var playerDie = [1,11,16,21,31,36,41,51,56,61,71,76]
var localPose = []
var winPose = [0,0,0,0]
@onready var playerPath = [$B1,$B2,$B3,$B4]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func playRun(x,y,globPos):
	localPose = globPos
	var finalPose = playerPos[x] +y
	if playerRun[x] == 1 :
	# 	if finalPose < 86:
	# 		diceFace = y
	# 		playerTurn = x
	# 		initialPos = playerPos[x]
	# 		playerPos[x] = playerPos[x] + y
	# 		chk_time()
	# 	if finalPose == 86:
		diceFace = y
		playerTurn = x
		initialPos = playerPos[x]
		playerPos[x] = playerPos[x] + y
		winPose[x] =  1
		chk_time()
	elif y == 6:
		var curvP = get_curve().get_point_position(0)
		playerPath[x].position.x = curvP.x
		playerPath[x].position.y = curvP.y
		playerRun[x] = 1
		emit_signal("outBoxBlue",x,1)
		
func chk_time(): 
	initialPos += 1
	var curvP = get_curve().get_point_position(initialPos)
	playerPath[playerTurn].position.x = curvP.x
	playerPath[playerTurn].position.y = curvP.y
	$Timer.start(0.2)
	
func _on_timer_timeout():
	$Timer.stop()
	if initialPos == playerPos[playerTurn]:
		kill_player()
	else:
		chk_time()
		
func kill_player():
	var set = []
	var dieTrue = 0
	var reset = 0
	if playerDie.find(playerPos[playerTurn]) != -1:
		dieTrue = 1
	if dieTrue == 0:
		for x in localPose.size():
			if playerPos[playerTurn] == localPose[x]:
				set.append(x)
	var loadPlayer = [0,1,2,3]
	if set.size() ==1:
		for y in loadPlayer.size():
			if set[0] == loadPlayer[y]:
				reset = 1
		if reset == 0:
			emit_signal("playDoneBlue",playerPos,playerTurn,diceFace,1,set[0])
		else:
			emit_signal("playDoneBlue",playerPos,playerTurn,diceFace,0,null)
	else:
		emit_signal("playDoneBlue",playerPos,playerTurn,diceFace,0,null)
func a():
	