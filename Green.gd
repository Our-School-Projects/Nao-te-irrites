extends Path2D

var playerRun = [0,0,0,0]
var playerPos = [0,0,0,0]
var playerIn = [0,0,0,0]
signal playDoneGreen
signal outBoxGreen
var diceFace = 0
var playerTurn = 0
var initialPos = 0
var playerDie = [1,11,16,21,31,36,41,51,56,61,71,76]
var localPose = []
@onready var playerPath = [$G1,$G2,$G3,$G4]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func playRun(x,y,globPos):
	localPose = globPos
	if playerRun[x] == 1 :
		playerIn[x] += y
		diceFace = y
		playerTurn = x
		initialPos = playerPos[x] + y
		chk_time()
	elif y == 6:
		var curvP = get_curve().get_point_position(0)
		playerPath[x].position.x = curvP.x
		playerPath[x].position.y = curvP.y
		playerRun[x] = 1
		playerIn[x] = 41
		emit_signal("outBoxGreen",x,1)
		
func chk_time():
	initialPos += 1
	var curvP = get_curve().get_point_position(initialPos)
	playerPath[playerTurn].position.x = curvP.x
	playerPath[playerTurn].position.y = curvP.y
	$Timer.start(0.5)
	
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
	if playerDie.find(playerIn[playerTurn]) != -1:
		dieTrue = 1
	if dieTrue == 0:
		for x in localPose.size():
			if playerIn[playerTurn] == localPose[x]:
				set.append(x)
	var loadPlayer = [0,1,2,3]
	if set.size() ==1:
		for y in loadPlayer.size():
			if set[0] == loadPlayer[y]:
				reset = 1
		if reset == 0:
			emit_signal("playDoneGreen",playerTurn,diceFace,1,set[0])
		else:
			emit_signal("playDoneGreen",playerTurn,diceFace,0,null)
	else:
		emit_signal("playDoneGreen",playerTurn,diceFace,0,null)
